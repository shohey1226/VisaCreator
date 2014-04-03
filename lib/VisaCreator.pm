package VisaCreator;

use Mojo::Base 'Mojolicious';
use VisaCreator::Model;
use FindBin qw($Bin);
use Data::Dumper;
use Log::Minimal;

# This method will run once at server start
sub startup {
  my $self = shift;

  # To download files
  $self->plugin('RenderFile');

  # Load config and instantiate Model which can be used anywhere through helper
  my $config = $self->plugin('Config', {file => "$Bin/../etc/visa_creator.conf"});
  $self->helper(config => sub {$config });

  my $m = VisaCreator::Model->new(config => $config);
  $self->helper(model => sub { $m });

  # Router
  my $r = $self->routes;
  push @{$r->namespaces}, 'VisaCreator::Controllers';
  # Normal route to controller
  $r->get('/')->to('Index#serve_root');
  #$r->post('/api/japan/form')->to('Japan#save_form');
  $r->post('/api/japan/form')->to('Japan#create_form');
  $r->get('/japan/form/download/:file')->to('Japan#download_form');

  # Delete pdf file once it's downloaded
  $self->hook(after_dispatch => sub {
    my $c = shift;
    #debugf "deleting downloaded pdf file if needed\n";
    #print Dumper $c->res;
    #if (defined $c->res->{code} == 200){
    #  unlink $c->res->{content}->{asset}->{path};
    #}
  });

}

1;
