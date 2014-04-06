package VisaCreator::Model;

use Moo;
use VisaCreator::DB;
use Data::Dumper;
use Mojo::JSON qw(decode_json);

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

sub find_id {
    my ($self, $search_key) = @_;
    my $row = $self->db->single('user', $search_key);
    return defined $row ? $row->id : undef;
}

sub insert_fb_info {
    my ($self, $fb_info) = @_;
    my $data;
    $data->{facebook_id} = $fb_info->{id};
    $data->{email} = $fb_info->{email} if (defined $fb_info->{email});
    $data->{firstname} = $fb_info->{first_name} if (defined $fb_info->{first_name});
    $data->{lastname} = $fb_info->{last_name} if (defined $fb_info->{last_name});
    $data->{gender} = $fb_info->{gender} if (defined $fb_info->{gender});
    $data->{dateOfBirth} = $fb_info->{birthday} if (defined $fb_info->{birthday});
    my $row = $self->db->insert('user', $data); 
    return $row->id;
}

sub save_form {
    my ($self, $id, $type, $data) = @_;
    if ($type eq 'japan'){
        $self->_save_japan_form($id, 'mandatory', $data->{userinfo});
        for my $type ( keys %{ $data->{store} } ){
            if (decode_json $data->{store}->{$type} == 1){
                $self->_save_japan_form($id, $type, $data->{userinfo});
            }
        }
    }
}

sub _save_japan_form {
    my ($self, $id, $type, $userinfo) = @_;
    my $data;
    if($type eq 'mandatory'){
        # update user table
        $data->{firstname} = $user_info->{firstname} if (defined $user_info->{firstname});
        $data->{lastname} = $user_info->{surname} if (defined $user_info->{surname});
        $data->{othername} = $user_info->{otherame} if (defined $user_info->{othername});
        $data->{gender} = $user_info->{gender} if (defined $user_info->{gender});
        $self->db->update('user', $data, +{id => $id}) if (scalar keys $data > 0);

        # update travel travel/accommodation table
        $data = {};

    }elsif ($type eq 'basic'){

        # basic info on user table
        $data->{dateOfBirth} = $user_info->{} if (defined $user_info->{});
        $data->{placeOfBirth} = $user_info->{} if (defined $user_info->{});
        $data->{martialstatus} = $user_info->{} if (defined $user_info->{});
        $data->{dateOfIssue} = $user_info->{} if (defined $user_info->{});
        $data->{passportType} = $user_info->{} if (defined $user_info->{});
        $data->{residentialAddress} = $user_info->{} if (defined $user_info->{});
        $data->{residentialTel} = $user_info->{} if (defined $user_info->{});
        $data->{residentialMobileNo} = $user_info->{} if (defined $user_info->{});
        $data->{occupation} = $user_info->{} if (defined $user_info->{});
        $data->{partner_occupation} = $user_info->{} if (defined $user_info->{});

    }elsif ($type eq 'personal'){
        $data->{passpportNo} = $user_info->{passpportNo} if (defined $user_info->{passpportNo});
        $data->{id} = $user_info->{id} if (defined $user_info->{id});
    }elsif ($type eq 'employer'){
        #$data->{} = $user_info->{} if (defined $user_info->{});
        #$data->{} = $user_info->{} if (defined $user_info->{});
        #$data->{} = $user_info->{} if (defined $user_info->{});
        

    }elsif ($type eq 'supporter'){

    }
}

sub get_form_data {
    my ($self, $id) = @_;
    my $row = $self->db->single('user', { id => $id } );
    return $row->get_columns;
}

1;
