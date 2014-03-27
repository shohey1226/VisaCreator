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

1;
