package VisaCreator;

use Mojo::Base 'Mojolicious';
use VisaCreator::Model;
use FindBin qw($Bin);
use Data::Dumper;
use Log::Minimal;
use File::Basename;
use Mojolicious::Plugin::Web::Auth;
use Plack::Session;
use utf8;
use JSON::XS;

# This method will run once at server start
sub startup {
  my $self = shift;

  # To download files
  $self->plugin('RenderFile');

  # Load config and instantiate Model which can be used anywhere through helper
  my $config = $self->plugin('Config', {file => "$Bin/../etc/visa_creator.conf"});
  $self->helper(config => sub {$config });

  # set model to helper
  my $m = VisaCreator::Model->new(config => $config);
  $self->helper(model => sub { $m });

  # Facebook login
  $self->plugin('Web::Auth',
    module      => 'Facebook',
    key         => $config->{fb_app_id},
    secret      => $config->{fb_secret}, 
    scope       => 'email,user_birthday,user_location',
    on_finished => sub {
      my ( $c, $access_token, $user_info ) = @_;
        print Dumper $user_info;
        my $session = Plack::Session->new( $c->req->env );
        $session->set( 'first_name', $user_info->{first_name});
        $session->set( 'fb_id', $user_info->{id});
        #$m->insert_fb_info($user_info);

        #print Dumper $c;
        #print Dumper $access_token,
        ##my $screen_name = $ref->{screen_name};
        ## my $id = 't'. $ref->{id};
        #$session->set( 'access_token',        $access_token );
        #$session->set( 'access_token_secret', $access_secret );
        #$session->set( 'screen_name',         $screen_name );
        #$session->set( 'user_id',             $id );
    },
  );

  # Add Controllers 
  my $r = $self->routes;
  push @{$r->namespaces}, 'VisaCreator::Controllers';

  #=====================
  # Route to controller
  #=====================
  # For API
  $r->get('/')->to('Index#serve_root');
  #$r->post('/api/japan/form')->to('Japan#save_form');
  $r->post('/api/japan/form')->to('Japan#create_form');
  $r->get('/api/login/status')->to('Index#login_status');

  $r->get('/japan/form/download/:file')->to('Japan#download_form');

  # For authentication
  $r->get('/auth/facebook/callback')->to('index#fb_callback');
  $r->get('/auth/logout')->to('index#logout');
  $r->post('/auth/whereami')->to('index#whereami');

  # Delete pdf file after 5 min (assume that the download finishes in 5 min);
  $self->hook(after_dispatch => sub {
    my $c = shift;
    if ($c->res->{content}->{headers}->{headers}->{'content-type'}->[0]->[0] =~ /application\/x-download;name=\"(\S+).pdf\"/){
        debugf "Deleting $c->res->{content}->{asset}->{path}...";
        system 'sleep 300 && rm ' . $c->res->{content}->{asset}->{path} . ' &';
    }
  });


}

1;
