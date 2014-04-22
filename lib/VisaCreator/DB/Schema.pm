package VisaCreator::DB::Schema;
use Teng::Schema::Declare;
use DateTime::Format::MySQL;

table {
    name 'user';
    pk 'id';
    columns qw/id facebook_id twitter_id google_id email firstname 
               lastname gender birthday created_at/;
    inflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->parse_datetime($value);
    };
    deflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

1;
