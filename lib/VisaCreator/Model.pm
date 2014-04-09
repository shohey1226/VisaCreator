package VisaCreator::Model;

use Moo;
use VisaCreator::DB;
use Data::Dumper;
use Hash::Merge qw( merge );
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

sub insert_twitter_info {
    my ($self, $ref) = @_;
    my $data;
    my $dt = DateTime->now();
    $data->{twitter_id} = $ref->{id};
    $data->{created_at} = $dt;
    my $row = $self->db->insert('user', $data); 
    return $row->id;
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
    $data->{birthday} = $self->_swap_dd($fb_info->{birthday}) if (defined $fb_info->{birthday});
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
    my $data = {};

    my $dt = DateTime->now();

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

        $data->{birthday} = $user_info->{dateOfBirth} if (defined $user_info->{dateOfBirth});

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

        if (defined $id && defined $travel_id && defined $accommodation_id){
            $data = {};
            $data->{user_id} = $id;
            $data->{travel_id} = $travel_id;
            $data->{accommodation_id} = $accommodation_id;
            if (scalar keys $data > 0){
                my $r = $self->db->single('travel_map', $data);
                unless ( defined $r ) {
                    $data->{created_at} = $dt;
                    $self->db->insert('travel_map', $data);
                }
            }
        }

    }elsif ($type eq 'basic'){

        # basic info on user table
        $data->{birth_place} = $user_info->{placeOfBirth} if (defined $user_info->{placeOfBirth});

        if (defined $user_info->{martialStatusMarried}){
            $data->{martialstatus} = "married";
        }elsif (defined $user_info->{martialStatusSingle}){
            $data->{martialstatus} = "single";
        }elsif (defined $user_info->{martialStatusWidowed}){
            $data->{martialstatus} = "widowed";
        }elsif (defined $user_info->{martialStatusDivorced}){
            $data->{martialstatus} = "divorced";
        }

        $data->{residential_address} = $user_info->{residentialAddress} if (defined $user_info->{residentialAddress});
        $data->{residential_tel} = $user_info->{residentialTel} if (defined $user_info->{residentialTel});
        $data->{residential_mobile} = $user_info->{residentialMobileNo} if (defined $user_info->{residentialMobileNo});
        $data->{partner_occupation} = $user_info->{partner} if (defined $user_info->{partner});
        $data->{occupation} = $user_info->{profession} if (defined $user_info->{profession});
        $self->db->update('user', $data, +{id => $id}) if (scalar keys $data > 0);

    }elsif ($type eq 'personal'){

        $data->{passpport_no} = $user_info->{passpportNo} if (defined $user_info->{passpportNo});
        $data->{identification} = $user_info->{id} if (defined $user_info->{id});
        $data->{issue_date} = $user_info->{dateOfIssue} if (defined $user_info->{dateOfIssue});
        $data->{expiry_date} = $user_info->{dateOfExpiry} if (defined $user_info->{dateOfExpiry});
        $data->{issuing_auth} = $user_info->{issuingAuth} if (defined $user_info->{issuingAuth});
        $data->{issue_place} = $user_info->{placeOfIssue} if (defined $user_info->{placeOfIssue});

        if (defined $user_info->{passportTypeDiplomatic}){
            $data->{passport_type} = 'diplomatic'; 
        }elsif (defined $user_info->{passportTypeOfficial}){
            $data->{passport_type} = 'official';
        }elsif (defined $user_info->{passportTypeOrdinary}){
            $data->{passport_type} = 'ordinary';
        }elsif (defined $user_info->{passportTypeOther}){
            $data->{passport_type} = 'other';
        }

        if (defined $user_info->{crimeYes}){
            $data->{crime} = 'yes';
        }elsif (defined $user_info->{crimeNo}){
            $data->{crime} = 'no';
        }

        if (defined $user_info->{sentencedYes}){
            $data->{sentenced} = 'yes';
        }elsif (defined $user_info->{sentencedNo}){
            $data->{sentenced} = 'no';
        }

        if (defined $user_info->{drugYes}){
            $data->{drug} = 'yes';
        }elsif (defined $user_info->{drugNo}){
            $data->{drug} = 'no';
        }

        if (defined $user_info->{overstayYes}){
            $data->{overstay} = 'yes';
        }elsif (defined $user_info->{overstayNo}){
            $data->{overstay} = 'no';
        }

        if (defined $user_info->{prostitutionYes}){
            $data->{prostitution} = 'yes';
        }elsif (defined $user_info->{prostitutionNo}){
            $data->{prostitution} = 'no';
        }

        if (defined $user_info->{traffickingYes}){
            $data->{trafficking} = 'yes';
        }elsif (defined $user_info->{traffickingNo}){
            $data->{trafficking} = 'no';
        }

        $data->{nationality} = $user_info->{nationality} if (defined $user_info->{nationality});
        $data->{former_nationality} = $user_info->{formerNationality} if (defined $user_info->{formerNationality});

        $self->db->update('user', $data, +{id => $id}) if (scalar keys $data > 0);


    }elsif ($type eq 'employer'){

        $data->{name} = $user_info->{employerName} if (defined $user_info->{employerName});
        $data->{address} = $user_info->{employerAddress} if (defined $user_info->{employerAddress});
        $data->{tel} = $user_info->{employerTel} if (defined $user_info->{employerTel});
        
        if (scalar keys $data > 0){
            my $row = $self->db->single('employer', $data);
            unless (defined $row){
                $row = $self->db->insert('employer', $data);
            }

            if(defined $row->id){
                $data = {};
                $data->{employer_id} = $row->id;
                $data->{user_id} = $id;
                my $r = $self->db->single('employer_map', $data);
                unless (defined $r) {
                    $data->{created_at} = $dt;
                    $self->db->insert('employer_map', $data);
                }
            }
        }

    }elsif ($type eq 'supporter'){
        
        $data->{name} = $user_info->{inviterName} if (defined $user_info->{inviterName});
        $data->{address} = $user_info->{inviterAddress} if (defined $user_info->{inviterAddress});
        $data->{birthday} = $user_info->{inviterDateOfBirth} if (defined $user_info->{inviterDateOfBirth});
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
            $map_data->{type} = 'inviter';

            my $r = $self->db->single('supporter_map', $map_data); 
            unless (defined $r){
                $map_data->{created_at} = $dt;
                $self->db->insert('supporter_map', $map_data); 
            }
        }

        $data = {};
        $data->{name} = $user_info->{guarantorName} if (defined $user_info->{guarantorName});
        $data->{address} = $user_info->{guarantorAddress} if (defined $user_info->{guarantorAddress});
        $data->{birthday} = $user_info->{guarantorDateOfBirth} if (defined $user_info->{guarantorDateOfBirth});
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
            $map_data->{type} = 'guarantor';
            $map_data->{relation} = $user_info->{guarantorRelationship};

            $row = $self->db->single('supporter_map', $map_data); 
            unless (defined $row){
                $self->db->insert('supporter_map', $map_data); 
            }
        }
    }
}

#==============================================================================
# Get form dispatch private method by country 
#==============================================================================
sub get_form {
    my ($self, $id, $country) = @_;
    if ($country eq 'japan'){
        return $self->_get_japan_form($id);
    }
}

# For japan
sub _get_japan_form {
    my ($self, $id) = @_;
    my $result = {};
    my $user = $self->_get_japan_form_user($id, $self->config->{japan}->{map}->{user});
    my $guarantor = $self->_get_japan_form_supporter($id, 'guarantor', $self->config->{japan}->{map}->{guarantor});
    my $inviter = $self->_get_japan_form_supporter($id, 'inviter', $self->config->{japan}->{map}->{inviter});
    my $travel = $self->_get_japan_form_travel($id, $self->config->{japan}->{map}->{travel}, $self->config->{japan}->{map}->{accommodation});
    my $employer = $self->_get_japan_form_employer($id, $self->config->{japan}->{map}->{employer});
    $result = merge($guarantor, $user);
    $result = merge($inviter, $result);
    $result = merge($travel, $result);
    $result = merge($employer, $result);
    return $result;
}

sub _get_japan_form_employer{
    my ($self, $id, $map) = @_;
    my $employer = {};
    my @rows = $self->db->search(
        'employer_map', 
        +{user_id => $id}, 
        +{limit => 1, order_by => 'created_at'}
    );
    return $employer if(scalar @rows == 0);
    my $r = $self->db->single('employer', +{ id => $rows[0]->employer_id });
    return $employer unless (defined $r);

    for my $colname (keys %{ $r->get_columns }){
        my $varname = $map->{$colname};
        next if (! defined $varname);
        my $val = $r->get_column($colname);
        next if (! defined $val);
        $employer->{$varname} = $val; 
    }
    return $employer;
}

sub _get_japan_form_travel{
    my ($self, $id, $map_travel, $map_accommodation) = @_;

    my $travel = {};
    my @rows = $self->db->search(
        'travel_map', 
        +{user_id => $id}, 
        +{limit => 1, order_by => 'created_at'}
    );
    return $travel if(scalar @rows == 0);

    my $r = $self->db->single('travel', +{ id => $rows[0]->travel_id });
    my $ro = $self->db->single('accommodation', +{ id => $rows[0]->accommodation_id });

    if (defined $r){
        for my $colname (keys %{ $r->get_columns }){
            my $varname = $map_travel->{$colname};
            next if (! defined $varname);
            my $val = $r->get_column($colname);
            next if (! defined $val);
            $travel->{$varname} = $val; 
        }
    }

    if (defined $ro){
        for my $colname (keys %{ $ro->get_columns }){
            my $varname = $map_accommodation->{$colname};
            next if (! defined $varname);
            my $val = $ro->get_column($colname);
            next if (! defined $val);
            $travel->{$varname} = $val; 
        }
    }
    return $travel;
}


sub _get_japan_form_supporter{
    my ($self, $id, $type, $map) = @_;
    my $supporter = {};
    my @rows = $self->db->search(
        'supporter_map', 
        +{user_id => $id, type => $type}, 
        +{limit => 1, order_by => 'created_at'}
    );
    return $supporter if(scalar @rows == 0);

    my $row = shift @rows;
    my $r = $self->db->single('supporter', +{ id => $row->supporter_id });
    return $supporter unless(defined $r);

    for my $colname (keys %{ $r->get_columns }){
        my $varname = $map->{$colname};
        next if (! defined $varname);
        my $val = $r->get_column($colname);
        next if (! defined $val);
        $supporter->{$varname} = $val; 
    }

    $supporter->{"${type}Relationship"} = $row->relation
        if(defined $row->relation);
    return $supporter;
}

#------------------------------------------------------------------------------
# compose the return value 
#------------------------------------------------------------------------------
sub _get_japan_form_user{
    my ($self, $id, $map) = @_; 
    my $user = {};
    my $row = $self->db->single('user', { id => $id } );
    for my $colname (keys %{ $row->get_columns } ){
        my $varname = $map->{$colname}; 
        next if (! defined $varname);
        my $val = $row->get_column($colname);
        next if (! defined $val);
        $user->{$varname} = $val; 
    }
    return $user;
}


sub _swap_dd{
    my ($self, $date) = @_;
    $date =~ /(\d+)\/(\d+)\/(\d+)/;
    return "$2/$1/$3"; 
}

1;
