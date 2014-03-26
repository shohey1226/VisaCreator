'use strict';

angular.module('VisaCreatorApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/top.html',
        controller: 'TopCtrl'
      })
      .when('/main', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/japan-visa-form', {
        templateUrl: 'views/japan-visa-form.html',
        controller: 'japanVisaFormCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
