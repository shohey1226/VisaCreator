package VisaCreator::Service::PDFMaker;

use Moo;
use PDF::API2;
use Data::Dumper;

has infile => (
    is => 'ro',
);

 
## Create a blank PDF file
#my $pdf = PDF::API2->new();
# 
#my $infile  = "$Bin/../etc/application1-1.pdf";
#
## Open an existing PDF file
#$pdf = PDF::API2->open($infile);
#my $page = $pdf->openpage(1);
#my $font = $pdf->corefont('Helvetica-Bold');
#
#my $text = $page->text();
#$text->font($font, 20);
#$text->translate(200, 700);
#$text->text('Hello World!');
#
#$pdf->saveas('new.pdf');



1;
