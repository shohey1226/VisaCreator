package VisaCreator::Controllers::Japan;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub save_form {
    my $self = shift;
    my $data = $self->req->json; 
    print Dumper $data;
    $self->render( text => "pass");
}
1;
