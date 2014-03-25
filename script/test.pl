#!/usr/bin/env perl

use strict;
use warnings;

use CAM::PDF;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;

my $infile  = "$Bin/../etc/application1.pdf";
my $outfile = 'output.pdf';

print "$infile\n";

my $pdf     = CAM::PDF->new($infile) or die "error:$!";
my @FIELDS  = $pdf->getFormFieldList();

print Dumper @FIELDS;
 
#foreach my $field ( @FIELDS ) {
#    if ($field =~ /^c/) {
#        my $ff_obj    = $pdf->getFormField($field);
#        $ff_obj->{value}->{value}->{AS}->{value} = 'Yes';  #This line sets a check in the checkbox fields
#    }
# 
#    else {
#        $pdf->fillFormFields($field => $field);  #This line sets the value of the field to the field name.
#    }
#}
#$pdf->cleanoutput($outfile);

print "test\n";
