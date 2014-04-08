package VisaCreator::Controllers::Japan;

use Mojo::Base 'Mojolicious::Controller';
use Plack::Session;
use Data::Dumper;
use Moo;
use Log::Minimal;
use FindBin qw($Bin);

with ('VisaCreator::Role::PDF');

sub create_form {
    my $self = shift;

    # user needs to be logged in
    my $session = Plack::Session->new( $self->req->env );
    my $id = $session->get('id');
    unless (defined $id) {
        $self->render(json => { { Message => 'No ID is found. Need to login to proceed.'}, status => 510 });
    }

    my $data = $self->req->json;
    print Dumper $data;
    $self->model->save_form($id, 'japan', $data);
    my $pdf_name = $self->pdfmaker->create('japan', 'form', $self->config, $data->{userinfo});
    debugf "PDF name: $pdf_name";
    $self->render( json => { url => "/japan/form/download/$pdf_name" });
}

sub download_form {
    my $self = shift;
    my $file = $self->param('file');
    print Dumper $file;
    $self->render_file('filepath' => "/tmp/${file}", 'filename' => 'japan_visa_form.pdf');
}

sub get_form {
    my $self = shift;
    my $session = Plack::Session->new( $self->req->env );
    my $id = $session->get('id');
    unless (defined $id) {
        $self->render(json => { { Message => 'No ID is found. Need to login to proceed.'}, status => 510 } );
    }
    my $info = $self->model->get_form($id, 'japan');
    $self->render(json => $info);
}

1;
