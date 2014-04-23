package VisaCreator::Util;

use Moo;
use JSON::XS;
use Crypt::CBC;
use IO::Compress::Gzip qw(gzip $GzipError) ;
use IO::Uncompress::Gunzip qw(gunzip $GunzipError) ;
use MongoDB::BSON::Binary;

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
    my $hex_in = $self->cipher->encrypt_hex( $self->serialize($hash_or_array) );
    my $bin_out;
    gzip \$hex_in => \$bin_out;
    return MongoDB::BSON::Binary->new(data => $bin_out);
}

sub decrypt {
    #my ($self, $hex) = @_;
    #return $self->deserialize( $self->cipher->decrypt_hex( $hex ) );
    my ($self, $bin) = @_;
    my $hex_out;
    gunzip \$bin => \$hex_out;
    return $self->deserialize( $self->cipher->decrypt_hex( $hex_out ) );
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
