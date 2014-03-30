package VisaCreator::Model;

use Moo;
use VisaCreator::DB;
use Data::Dumper;

has config => (
    is => 'ro',
    required => 1,
);

has db => (
    is => 'ro',
    lazy => 1, 
    builder => '_build_db',
);

sub _build_db {
    my $self = shift;
    return VisaCreator::DB->new(
        +{
            connect_info => 
                [
                    $self->config->{dsn},
                    $self->config->{user},
                    $self->config->{password}
                ]
        }
    );
}

sub save_form {
    my ($self, $data) = @_;
    $self->db->insert('user', $data); 
}

sub get_form_data {
    my ($self, $id) = @_;
    my $row = $self->db->single('user', { id => $id } );
    return $row->get_columns;
}

1;
