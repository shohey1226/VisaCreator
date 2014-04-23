#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use VisaCreator::Util;
use Data::Dumper;


my $hash = { name => "foo" x 200 };
my $util = VisaCreator::Util->new(key => "1111111111111111111111111111111111111111111111111111111111");
my $data = $util->encrypt($hash);
print $data;

print "\n\n";
my $text = $util->decrypt($data);
print Dumper $text;

