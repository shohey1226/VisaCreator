package VisaCreator::Service::PDFMaker;

use Moo;
use PDF::API2;
use FindBin qw($Bin);
use Log::Minimal;
use Data::Printer;
use Digest::SHA qw(sha256_hex);

has y_max => (
    is => 'ro',
    default => 842
);


sub create {
    my ($self, $country, $form_type, $config, $data ) = @_;

    #p $data;
    #p $config;
    my $infile  = "$Bin/../etc/" . $country . "/" . $config->{$country}->{$form_type}->{base};
    my $pdf = PDF::API2->open($infile);
    debugf "loading $infile ...";

    for my $field ( keys %{ $config->{$country}->{$form_type}->{positions} }){
        my $page = $pdf->openpage($config->{$country}->{$form_type}->{positions}->{$field}->{page});
        my $font = $pdf->corefont($config->{font});
        my $text = $page->text();
        $text->font($font, $config->{$country}->{$form_type}->{positions}->{$field}->{font_size}); 
        $text->translate(
            $config->{$country}->{$form_type}->{positions}->{$field}->{x}, 
            $self->y_max - $config->{$country}->{$form_type}->{positions}->{$field}->{y} 
        );
        $text->text($data->{$field});
    }

    my $timestamp = time();
    my $hash = sha256_hex ($timestamp . $config->{salt} );
    #my $outfile = "/tmp/" . $country . "_" . $form_type . '_' . $data->{id} . ".pdf";
    my $outfile = $country . "_" . $form_type . "_" . $hash;
    $pdf->saveas("/tmp/$outfile");
    debugf "output $outfile ...\n";
    return $outfile;
    
}


1;
