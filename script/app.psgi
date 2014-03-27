use Mojo::Server::PSGI;
use Plack::Builder;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use VisaCreator; 

if ($ENV{'MOJO_MODE'} eq 'development'){
    $ENV{LM_DEBUG}  = 1;
}

my $psgi = Mojo::Server::PSGI->new( app => VisaCreator->new );
my $app = sub { $psgi->run(@_) };

builder {
    enable 'Session', store => 'File';
    $app;
};
