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
    my $pdf_name = $self->pdfmaker->create('japan', 'form', $self->config, $data);
    print Dumper  $pdf_name;
    $self->render( json => { url => "/japan/form/download/$pdf_name" });
}

sub download_form {
    my $self = shift;
    my $file = $self->param('file');
    print Dumper $file;
    $self->render_file('filepath' => "/tmp/${file}", 'filename' => 'japan_visa_form.pdf');
}

1;
