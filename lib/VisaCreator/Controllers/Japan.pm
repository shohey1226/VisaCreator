package VisaCreator::Controllers::Japan;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Moo;
use Log::Minimal;

with ('VisaCreator::Role::PDF');

sub save_form {
    my $self = shift;
    my $data = $self->req->json; 
    debugf Dumper $data;
    $self->model->db->insert('user', +{ surname => $data->{surname} });
    $self->render( text => "pass");
}


1;
