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
      .when('/japan-visa-form-step1', {
        templateUrl: 'views/japan-visa-form-step1.html',
        controller: 'japanVisaFormCtrlStep1'
      })
      .when('/japan-visa-form-step2', {
        templateUrl: 'views/japan-visa-form-step2.html',
        controller: 'japanVisaFormCtrlStep2'
      })
      .when('/japan-visa-form-step3', {
        templateUrl: 'views/japan-visa-form-step3.html',
        controller: 'japanVisaFormCtrlStep3'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
