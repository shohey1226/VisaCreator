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
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/JapanVisaForm', {
        templateUrl: 'views/japanVisaForm.html',
        controller: 'japanVisaFormCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
