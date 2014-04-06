package VisaCreator::DB::Schema;
use Teng::Schema::Declare;
use DateTime::Format::MySQL;

table {
    name 'user';
    pk 'id';
    columns qw/id facebook_id email firstname lastname othername gender dateOfBirth 
               placeOfBirth created_at updated_at martialstatus passpportNo 
               dateOfIssue dateOfExpiry issuingAuth placeOfIssue passportType 
               residentialAddress residentialTel residentialMobileNo 
               occupation partner_occupation/;
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
