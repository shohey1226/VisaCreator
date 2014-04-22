#!/usr/bin/env perl

use MongoDB;
use Data::Dumper;


my $client     = MongoDB::MongoClient->new(
    host => 'localhost', 
    port => 27017, 
    username => "visa_test", 
    password => "visa_test",
    db_name => 'visa_test',
);
print Dumper $client;
