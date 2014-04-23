#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use VisaCreator::Util;
use IO::Compress::Gzip qw(gzip $GzipError) ;
use IO::Uncompress::Gunzip qw(gunzip $GunzipError) ;
use MongoDB::BSON::Binary;
use Data::Dumper;


my $hash = { name => "foo" x 200 };
my $util = VisaCreator::Util->new(key => "1111111111111111111111111111111111111111111111111111111111");
my $data = $util->encrypt($hash);
my $out;
print $data;
gzip \$data => \$out;
#print Dumper $out;

my $bson_bin = MongoDB::BSON::Binary->new(data => $out);
#print Dumper $bson_bin;

print "\n" x 3;

my $revert;
gunzip \$out => \$revert;
print $revert, "\n";

print "\n\n";
my $text = $util->decrypt($revert);
print Dumper $text;

