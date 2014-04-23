package VisaCreator::Model;

use Moo;
use VisaCreator::DB;
use Data::Dumper;
use Hash::Merge qw( merge );
use DateTime;
use Mojo::JSON qw(decode_json);
use MongoDB;
use Log::Minimal;
use VisaCreator::Util;

has config => (
    is => 'ro',
    required => 1,
);

has db => (
    is => 'ro',
    lazy => 1, 
    builder => '_build_db',
);

has mongo => (
    is => 'ro',
    lazy => 1,
    builder => '_build_mongo',
);

has util => (
    is => 'ro',
    lazy => 1,
    builder => '_build_util',
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

sub _build_mongo{
    my $self = shift;
    my $c = MongoDB::MongoClient->new(
        host => $self->config->{mongo_host},
        port => $self->config->{mongo_port},
        username => $self->config->{mongo_username},
        password => $self->config->{mongo_password},
        db_name => $self->config->{mongo_db_name},
    ); 
    return $c->get_database($self->config->{mongo_db_name});
}

sub _build_util{
    my $self = shift;
    return VisaCreator::Util->new(key => $self->config->{secret_key});
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

sub insert_google_info {
    my ($self, $ref) = @_;
    my $data;
    my $dt = DateTime->now();
    $data->{google_id} = $ref->{id};
    $data->{firstname} = $ref->{name}->{givenName}
        if(defined $ref->{name}->{givenName});
    $data->{lastname} = $ref->{name}->{familyName}
        if(defined $ref->{name}->{familyName});
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
    my $row = $self->db->insert('user', $data); 
    return $row->id;
}

sub filter_user_preference{
    my ($self, $visa_type, $data) = @_;
    for my $type ( keys %{ $data->{store} } ){
        # if 1, then save. Otherwise, drop
        if (( decode_json $data->{store}->{$type} ) != 1){
            for my $field ( @{ $self->config->{$visa_type}->{store_fields}->{$type} }){
                delete $data->{userinfo}->{$field} if (defined $data->{userinfo}->{$field});
            }
        }
    } 
    return $data->{userinfo};
}

sub get_form {
    my ($self, $id, $country) = @_;
    # first try to get with visa_type
    my $cursor = $self->mongo->get_collection('visa')->find({user_id => $id, visa_type => $country})->sort({created_at => -1})->limit(1);
    my $obj = $cursor->next;
    #debugf Dumper $obj;
    return $self->util->decrypt($obj->{data}) if (defined $obj);

    # next, try to get the latest one without visa_type 
    $cursor = $self->mongo->get_collection('visa')->find({user_id => $id})->sort({created_at => -1})->limit(1);
    $obj = $cursor->next;
    #debugf Dumper $obj;
    return $self->util->decrypt($obj->{data}) if (defined $obj);

    # no, then return 0
    return 0;
}

sub save_form {
    my ($self, $id, $type, $data) = @_;
    my $raw_info = $self->filter_user_preference($type, $data);
    my $info = $self->util->encrypt($raw_info);
    my $epoch = time();
    #debugf "adding at epoch:$epoch as user_id:$id - " . Dumper($info);

    my $cursor = $self->mongo->get_collection('visa')->find( {user_id => $id, visa_type => $type } );
    my $obj = $cursor->next;
    if (defined $obj){
        $self->mongo->get_collection('visa')->update( {user_id => $id, visa_type => $type }, { '$set' => { data => $info, created_at => $epoch } } );
    }else{
        $self->mongo->get_collection('visa')->insert( {user_id => $id, data => $info, visa_type => $type, created_at => $epoch } );
    }
}

1;
