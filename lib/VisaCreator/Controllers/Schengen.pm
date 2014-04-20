package VisaCreator::Controllers::Schengen;

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

    $self->model->save_form($id, 'schengen', $data);

    # concat employer
    $data->{userinfo}->{employer} = ""; 
    $data->{userinfo}->{employer} .=  $data->{userinfo}->{employerName} if (defined $data->{userinfo}->{employerName});
    $data->{userinfo}->{employer} .=  $data->{userinfo}->{employerAddress} if (defined $data->{userinfo}->{employerAddress});
    $data->{userinfo}->{employer} .=  $data->{userinfo}->{employerName} if (defined $data->{userinfo}->{employerTel});

    # NO.31
    if ($data->{userinfo}->{existInviter} eq 'false' && $data->{userinfo}->{familyMember} eq 'false'){
        $data->{userinfo}->{thirtyoneName} = $data->{userinfo}->{accommodation} if (defined $data->{userinfo}->{accommodation});
        $data->{userinfo}->{thirtyoneAddress} = $data->{userinfo}->{accommodationAddress} if (defined $data->{userinfo}->{accommodationAddress});
        $data->{userinfo}->{thirtyoneEmail} = $data->{userinfo}->{accommodationEmail} if (defined $data->{userinfo}->{accommodationEmail});
        $data->{userinfo}->{thirtyoneTel} = $data->{userinfo}->{accommodationTel} if (defined $data->{userinfo}->{accommodationTel});
    }elsif ($data->{userinfo}->{existInviter} eq 'true' && $data->{userinfo}->{familyMember} eq 'false'){
        $data->{userinfo}->{thirtyoneName} = $data->{userinfo}->{inviterName} if (defined $data->{userinfo}->{inviterName});
        $data->{userinfo}->{thirtyoneAddress} = $data->{userinfo}->{inviterAddress} if (defined $data->{userinfo}->{inviterAddress});
        $data->{userinfo}->{thirtyoneEmail} = $data->{userinfo}->{inviterEmail} if (defined $data->{userinfo}->{inviterEmail});
        $data->{userinfo}->{thirtyoneTel} = $data->{userinfo}->{inviterTel} if (defined $data->{userinfo}->{inviterTel});
    }

    my $pdf_name = $self->pdfmaker->create('schengen', 'form', $self->config, $data->{userinfo});
    debugf "PDF name: $pdf_name";
    $self->render( json => { url => "/schengen/form/download/$pdf_name" });
}

sub download_form {
    my $self = shift;
    my $file = $self->param('file');
    print Dumper $file;
    $self->render_file('filepath' => "/tmp/${file}", 'filename' => 'schengen.pdf');
}

sub get_form {
    my $self = shift;
    my $session = Plack::Session->new( $self->req->env );
    my $id = $session->get('id');
    unless (defined $id) {
        $self->render(json => { { Message => 'No ID is found. Need to login to proceed.'}, status => 510 } );
    }
    my $info = $self->model->get_form($id, 'schengen');
    $self->render(json => $info);
}

1;
