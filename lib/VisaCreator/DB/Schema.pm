package VisaCreator::DB::Schema;
use Teng::Schema::Declare;
use DateTime::Format::MySQL;

table {
    name 'user';
    pk 'id';
    columns qw/id facebook_id twitter_id google_id email firstname 
               lastname othername gender birthday
               birth_place created_at updated_at martialstatus passport_no
               issue_date expiry_date issuing_auth issue_place passport_type
               residential_address residential_tel residential_mobile
               occupation partner_occupation nationality former_nationality
               identification crime sentenced overstay drug prostitution 
               trafficking/;
    inflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->parse_datetime($value);
    };
    deflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

table {
    name 'travel';
    pk 'id';
    columns qw/id purpose stay_length arrival_date departure_date port_entry
               destination airline_ship_name remarks created_at/;
    inflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->parse_datetime($value);
    };
    deflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

table {
    name 'accommodation';
    pk 'id';
    columns qw/id name address tel/;
};

table {
    name 'travel_map';
    pk 'id';
    columns qw/id user_id travel_id accommodation_id created_at/;
    inflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->parse_datetime($value);
    };
    deflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

table {
    name 'supporter';
    pk 'id';
    columns qw/id name tel address birthday gender occupation_position
            nationality_immigrant_status/;
    inflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->parse_datetime($value);
    };
    deflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

table {
    name 'supporter_map';
    pk 'user_id';
    columns qw/user_id supporter_id type relation created_at/;
    inflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->parse_datetime($value);
    };
    deflate qr/.+_at/ => sub {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

table {
    name 'employer';
    pk 'id';
    columns qw/id name address tel/;
};

table {
    name 'employer_map';
    pk 'user_id';
    columns qw/user_id employer_id created_at/;
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
