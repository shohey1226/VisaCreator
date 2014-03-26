package VisaCreator::Controllers::Index;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;

sub serve_root {
     my $self = shift;   
     print Dumper "adbakdjfa\n";
     # will render the index.html file found in the /public directory
     $self->render_static('/index.html');
}

1;
