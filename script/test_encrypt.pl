#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use VisaCreator::Util;
use Data::Dumper;
use MongoDB;

my $hash = { name => "foo" x 3 };
my $util = VisaCreator::Util->new(key => "111111111111111111111");
my $bson_bin = $util->encrypt($hash);

#print Dumper $bson_bin;

my $client     = MongoDB::MongoClient->new(
    host => 'localhost', 
    port => 27017, 
    username => "visa_test", 
    password => "visa_test",
    db_name => 'visa_test',
);


my $db = $client->get_database('visa_test');
$db->get_collection('test')->insert({ test_data => $bson_bin });

my $cursor = $db->get_collection('test')->find();
my $a = $cursor->next;

my $text = $util->decrypt($a->{test_data});
print Dumper $text;



