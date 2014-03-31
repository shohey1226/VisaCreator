package VisaCreator::Controllers::Japan;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Moo;
use Log::Minimal;
use FindBin qw($Bin);

with ('VisaCreator::Role::PDF');

sub save_form {
    my $self = shift;
    my $data = $self->req->json; 
    debugf Dumper $data;
    $self->model->save_form($data);
    $self->render( text => "pass");
}

sub create_form {
    my $self = shift;
    my $data = $self->req->json;
    print Dumper $data;
    #my $pdf_name = $self->pdfmaker->create('japan', 'form', $self->config, $data);
    #$self->render( text => $pdf_name);
    $self->render( json => { url => '/hoge' });
}

sub download_form {
    my $self = shift;
    my $id = $self->param('id');
    my $data = $self->model->get_form_data($id);
    my $pdf_name = $self->pdfmaker->create('japan', 'form', $self->config, $data);
    $self->render_file('filepath' => $pdf_name);
}

1;
