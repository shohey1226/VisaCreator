package VisaCreator::Role::PDF;

use Moo::Role;
use VisaCreator::Service::PDFMaker;

has pdfmaker => (
    is => 'ro',
    lazy => 1,
    builder => '_build_pdfmaker'
);

sub _build_pdfmaker {
    return VisaCreator::Service::PDFMaker->new(); 
}

1;

