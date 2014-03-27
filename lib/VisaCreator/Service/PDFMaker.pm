package VisaCreator::Service::PDFMaker;

use Moo;
use PDF::API2;
use Data::Dumper;
use FindBin qw($Bin);

sub create_form {
    my ($self, $data ) = @_;
    print Dumper $data;
    my $infile  = "$Bin/../etc/application1-1.pdf";
    my $pdf = PDF::API2->open($infile);
    my $page = $pdf->openpage(1);
    my $font = $pdf->corefont('Helvetica-Bold');
    my $text = $page->text();
    $text->font($font, 10); 
    $text->translate(226, 605);
    $text->text($data->{surname});
    $pdf->saveas('/tmp/new.pdf');
    return '/tmp/new.pdf';
}


1;
