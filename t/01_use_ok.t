
use Test::More;
use lib 'lib';

BEGIN { 
    use_ok( 'VisaCreator' ); 
    #use_ok( 'VisaCreator::Response' ); 
    #use_ok( 'VisaCreator::Request' ); 
    #use_ok( 'VisaCreator::Context' ); 
    #use_ok( 'VisaCreator::Config' ); 
    #use_ok( 'VisaCreator::Config::Route' ); 
    #use_ok( 'VisaCreator::View::Xslate' ); 
    use_ok( 'VisaCreator::Controllers::Index' ); 
    use_ok( 'VisaCreator::Controllers::Japan' ); 
    use_ok( 'VisaCreator::Service::PDFMaker' ); 
    use_ok( 'VisaCreator::DB' ); 
    use_ok( 'VisaCreator::DB::Schema' ); 
    use_ok( 'VisaCreator::Role::PDF' ); 
    #use_ok( 'VisaCreator::Util' ); 
    #use_ok( 'VisaCreator::Service::User' ); 
    #use_ok( 'VisaCreator::Service::Theme' ); 
    #use_ok( 'VisaCreator::Service::InfoCollection' ); 
    use_ok( 'VisaCreator::Model' ); 
}
done_testing();

1;


