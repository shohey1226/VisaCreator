package VisaCreator;

use Mojo::Base 'Mojolicious';
use VisaCreator::Model;
use FindBin qw($Bin);
use Data::Dumper;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load config and instantiate Model which can be used anywhere through helper
  my $config = $self->plugin('Config', {file => "$Bin/../etc/visa_creator.conf"});
  my $m = VisaCreator::Model->new(config => $config);
  $self->helper(model => sub { $m });

  # Router
  my $r = $self->routes;
  push @{$r->namespaces}, 'VisaCreator::Controllers';
  # Normal route to controller
  $r->get('/')->to('Index#serve_root');
  $r->post('/api/japan/form')->to('Japan#save_form');

}

1;
