package VisaCreator::Util;

use Moo;
use JSON::XS;
use Crypt::CBC;

has cipher => (
    is => 'ro',
    lazy => 1,
    builder => '_build_cipher',
);

has key => (
    is => 'ro',
    required => 1,
);

sub _build_cipher{
    my $self = shift;
    return Crypt::CBC->new({ key => $self->key , cipher => 'Blowfish' });
}

sub serialize {
    my ($self, $hash_or_array) = @_;
    return encode_json $hash_or_array;
}

sub deserialize {
    my ($self, $json_text ) = @_;
    return decode_json $json_text;
}

sub encrypt {
    my ($self, $hash_or_array) = @_;
    return $self->cipher->encrypt_hex( $self->serialize($hash_or_array) );
}

sub decrypt {
    my ($self, $hex) = @_;
    return $self->deserialize( $self->cipher->decrypt_hex( $hex ) );
}

#sub get_salt{
#    my ($self, $text, $fixed_salt) = @_;
#    return $text . pack("H*", $fixed_salt);
#}
#
#sub get_hash{
#    my ($self, $id, $pass) = @_;
#    my $salt = $self->get_salt($id);
#    my $hash = '';
#    for (1..$self->config->{stretch_count}) {
#        $hash =  sha256_hex($hash . $pass . $salt);
#    }
#    return $hash;
#}

1;
