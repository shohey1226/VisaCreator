use Mojo::Server::PSGI;
use Plack::Builder;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use VisaCreator; 

my $psgi = Mojo::Server::PSGI->new( app => VisaCreator->new );
my $app = sub { $psgi->run(@_) };

builder {
    enable 'Session', store => 'File';
    $app;
};
