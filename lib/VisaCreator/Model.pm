package VisaCreator::Model;

use Moo;
use VisaCreator::DB;
use Data::Dumper;
use DateTime;
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
    my $dt = DateTime->now();
    $data->{facebook_id} = $fb_info->{id};
    $data->{email} = $fb_info->{email} if (defined $fb_info->{email});
    $data->{firstname} = $fb_info->{first_name} if (defined $fb_info->{first_name});
    $data->{lastname} = $fb_info->{last_name} if (defined $fb_info->{last_name});
    $data->{gender} = $fb_info->{gender} if (defined $fb_info->{gender});
    $data->{dateOfBirth} = $self->_swap_dd($fb_info->{birthday}) if (defined $fb_info->{birthday});
    $data->{created_at} = $dt;
    $data->{updated_at} = $dt;
    my $row = $self->db->insert('user', $data); 
    return $row->id;
}

sub save_form {
    my ($self, $id, $type, $data) = @_;
    if ($type eq 'japan'){
        $self->_save_japan_form($id, 'mandatory', $data->{userinfo});
        for my $type ( keys %{ $data->{store} } ){
            if (( decode_json $data->{store}->{$type} ) == 1){
                $self->_save_japan_form($id, $type, $data->{userinfo});
            }
        }
    }
}

sub _save_japan_form {
    my ($self, $id, $type, $user_info) = @_;
    my $data;
    if($type eq 'mandatory'){

        # update user table
        $data->{firstname} = $user_info->{firstname} if (defined $user_info->{firstname});
        $data->{lastname} = $user_info->{surname} if (defined $user_info->{surname});
        $data->{othername} = $user_info->{othername} if (defined $user_info->{othername});

        if (defined $user_info->{genderMale}){ 
            $data->{gender} = 'male'; 
        }elsif (defined $user_info->{genderFemale}){
            $data->{gender} = 'female'; 
        }

        $data->{dateOfBirth} = $user_info->{dateOfBirth} if (defined $user_info->{dateOfBirth});

        $self->db->update('user', $data, +{id => $id}) if (scalar keys $data > 0);

        # update travel 
        $data = {};
        $data->{purpose} = $user_info->{purpose} if (defined $user_info->{purpose});
        $data->{stay_length} = $user_info->{intendedLength} if (defined $user_info->{intendedLength});
        $data->{arrival_date} = $user_info->{arrivalDate} if (defined $user_info->{arrivalDate});
        $data->{port_entry} = $user_info->{portEntry} if (defined $user_info->{portEntry});
        $data->{airline_ship_name} = $user_info->{shipAirline} if (defined $user_info->{shipAirline});
        $data->{remarks} = $user_info->{remarks} if (defined $user_info->{remarks});

        my $travel_id;
        if (scalar keys $data > 0){
            my $row = $self->db->single('travel', $data);
            unless (defined $row) {
                $row = $self->db->insert('travel', $data);
            }
            $travel_id = $row->id;
        }

        # accommodation
        $data = {};
        $data->{name} = $user_info->{accommodation} if (defined $user_info->{accommodation});
        $data->{address} = $user_info->{accommodationAddress} if (defined $user_info->{accommodationAddress});
        $data->{tel} = $user_info->{accommodationTel} if (defined $user_info->{accommodationTel});
        
        my $accommodation_id;
        if (scalar keys $data > 0){
            my $row = $self->db->single('accommodation', $data);
            unless (defined $row) {
                $row = $self->db->insert('accommodation', $data);
            }
            $accommodation_id = $row->id;
        }

        $data = {};
        $data->{user_id} = $id;
        $data->{travel_id} = $travel_id;
        $data->{accommodation_id} = $accommodation_id;
        if (scalar keys $data > 0){
            my $row = $self->db->single('travel_map', $data);
            unless (defined $row) {
                $row = $self->db->insert('travel_map', $data);
            }
        }

    }elsif ($type eq 'basic'){

        # basic info on user table
        $data->{placeOfBirth} = $user_info->{placeOfBirth} if (defined $user_info->{placeOfBirth});

        if (defined $user_info->{martialStatusMarried}){
            $data->{martialstatus} = "married";
        }elsif (defined $user_info->{martialStatusSingle}){
            $data->{martialstatus} = "single";
        }elsif (defined $user_info->{martialStatusWidowed}){
            $data->{martialstatus} = "widowed";
        }elsif (defined $user_info->{martialStatusDivorced}){
            $data->{martialstatus} = "divorced";
        }

        $data->{residentialAddress} = $user_info->{residentialAddress} if (defined $user_info->{residentialAddress});
        $data->{residentialTel} = $user_info->{residentialTel} if (defined $user_info->{residentialTel});
        $data->{residentialMobileNo} = $user_info->{residentialMobileNo} if (defined $user_info->{residentialMobileNo});
        $data->{partner_occupation} = $user_info->{partner} if (defined $user_info->{partner});
        $data->{occupation} = $user_info->{profession} if (defined $user_info->{profession});
        $self->db->update('user', $data, +{id => $id}) if (scalar keys $data > 0);


    }elsif ($type eq 'personal'){

        $data->{passpportNo} = $user_info->{passpportNo} if (defined $user_info->{passpportNo});
        $data->{id} = $user_info->{id} if (defined $user_info->{id});
        $data->{dateOfIssue} = $user_info->{dateOfIssue} if (defined $user_info->{dateOfIssue});
        $data->{dateOfExpiry} = $user_info->{dateOfExpiry} if (defined $user_info->{dateOfExpiry});
        $data->{issuingAuth} = $user_info->{issuingAuth} if (defined $user_info->{issuingAuth});
        $data->{placeOfIssue} = $user_info->{placeOfIssue} if (defined $user_info->{placeOfIssue});

        if (defined $user_info->{passportTypeDiplomatic}){
            $data->{passportType} = 'diplomatic'; 
        }elsif (defined $user_info->{passportTypeOfficial}){
            $data->{passportType} = 'official';
        }elsif (defined $user_info->{passportTypeOrdinary}){
            $data->{passportType} = 'ordinary';
        }elsif (defined $user_info->{passportTypeOther}){
            $data->{passportType} = 'other';
        }

    }elsif ($type eq 'employer'){

        $data->{name} = $user_info->{name} if (defined $user_info->{name});
        $data->{address} = $user_info->{address} if (defined $user_info->{address});
        $data->{tel} = $user_info->{tel} if (defined $user_info->{tel});
        my $row = $self->db->single('employer', $data);
        unless (defined $row){
            $row = $self->db->insert('employer', $data);
        }
        $self->db->insert('employer_map', +{ employer_id => $row->id, user_id => $id});

    }elsif ($type eq 'supporter'){
        
        $data->{type} = 'inviter' if (defined $user_info->{inviterName});
        $data->{name} = $user_info->{inviterName} if (defined $user_info->{inviterName});
        $data->{address} = $user_info->{inviterAddress} if (defined $user_info->{inviterAddress});
        $data->{dateOfBirth} = $user_info->{inviterDateOfBirth} if (defined $user_info->{inviterDateOfBirth});
        $data->{tel} = $user_info->{inviterTel} if (defined $user_info->{inviterTel});
        $data->{occupation_position} = $user_info->{inviterProfession} if (defined $user_info->{inviterProfession});
        $data->{nationality_immigrant_status} = $user_info->{inviterNationality} if (defined $user_info->{inviterNationality});
        if (defined $user_info->{inviterGenderFemale}){
            $data->{gender} = 'female';
        }elsif (defined $user_info->{inviterGenderFemale}){
            $data->{gender} = 'male';
        }
        
        if (scalar keys $data > 0 ){
            my $row = $self->db->single('supporter', $data);
            unless (defined $row){
                $row = $self->db->insert('supporter', $data);
            }
            my $map_data;
            $map_data->{supporter_id} = $row->id;
            $map_data->{user_id} = $id;
            $map_data->{relation} = $user_info->{inviterRelationship};

            $row = $self->db->sngle('supporter_map', $map_data); 
            unless (defined $row){
                $self->db->insert('supporter_map', $map_data); 
            }
        }

        $data = {};
        $data->{type} = 'guarantor' if (defined $user_info->{guarantorName});
        $data->{name} = $user_info->{guarantorName} if (defined $user_info->{guarantorName});
        $data->{address} = $user_info->{guarantorAddress} if (defined $user_info->{guarantorAddress});
        $data->{dateOfBirth} = $user_info->{guarantorDateOfBirth} if (defined $user_info->{guarantorDateOfBirth});
        $data->{tel} = $user_info->{guarantorTel} if (defined $user_info->{guarantorTel});
        $data->{occupation_position} = $user_info->{guarantorProfession} if (defined $user_info->{guarantorProfession});
        $data->{nationality_immigrant_status} = $user_info->{guarantorNationality} if (defined $user_info->{guarantorNationality});
        if (defined $user_info->{guarantorGenderFemale}){
            $data->{gender} = 'female';
        }elsif (defined $user_info->{guarantorGenderFemale}){
            $data->{gender} = 'male';
        }
        
        if (scalar keys $data > 0 ){
            my $row = $self->db->single('supporter', $data);
            unless (defined $row){
                $row = $self->db->insert('supporter', $data);
            }
            my $map_data;
            $map_data->{supporter_id} = $row->id;
            $map_data->{user_id} = $id;
            $map_data->{relation} = $user_info->{guarantorRelationship};

            $row = $self->db->sngle('supporter_map', $map_data); 
            unless (defined $row){
                $self->db->insert('supporter_map', $map_data); 
            }
        }
    }
}

sub get_form_data {
    my ($self, $id) = @_;
    my $row = $self->db->single('user', { id => $id } );
    return $row->get_columns;
}

sub _swap_dd{
    my ($self, $date) = @_;
    $date =~ /(\d+)\/(\d+)\/(\d+)/;
    return "$2/$1/$3"; 
}

1;
