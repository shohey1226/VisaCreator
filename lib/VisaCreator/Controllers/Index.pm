package VisaCreator::Controllers::Index;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Log::Minimal;
use Plack::Session;

sub serve_root {
     my $self = shift;   
     # will render the index.html file found in the /public directory
     $self->render_static('/index.html');
}

sub fb_callback {
    my $self = shift;
    my $session = Plack::Session->new( $self->req->env );
    my $login_location = $session->get('login_location');
    $login_location = '/' unless(defined $login_location);
    debugf "I was at $login_location";
    $self->redirect_to('/#' . $login_location);
}

sub login_status {
    my $self = shift;
    my $session = Plack::Session->new( $self->req->env );
    my $fb_id = $session->get('fb_id');
    my $first_name = $session->get('first_name');
    my $result;
    $result->{login} = defined $fb_id ? 'true' : 'false';
    $result->{first_name} = defined $first_name ? $first_name : '';
    $self->render(json => $result);  
}

sub logout {
    my $self = shift;
    my $session = Plack::Session->new( $self->req->env );
    $session->expire();
    $self->redirect_to('/');
}

sub whereami {
    my $self = shift;
    my $data = $self->req->json;
    my $session = Plack::Session->new( $self->req->env );
    $session->set('login_location', $data->{location});
    $self->render(text => 'save the location');
}

1;
