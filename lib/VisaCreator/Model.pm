package VisaCreator::Model;

use Moo;

has 'config' => (
    is => 'ro',
    required => 1,
);

1;
