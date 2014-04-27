'use strict';

angular.module('VisaCreatorApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ngStorage'
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
        controller: 'visaFormCtrlStep1'
      })
      .when('/japan-visa-form-step2', {
        templateUrl: 'views/japan-visa-form-step2.html',
        controller: 'visaFormCtrlStep2'
      })
      .when('/japan-visa-form-step3', {
        templateUrl: 'views/japan-visa-form-step3.html',
        controller: 'visaFormCtrlStep3'
      })
      .when('/schengen-visa-form-step1', {
        templateUrl: 'views/schengen-visa-form-step1.html',
        controller: 'visaFormCtrlStep1'
      })
      .when('/schengen-visa-form-step2', {
        templateUrl: 'views/schengen-visa-form-step2.html',
        controller: 'visaFormCtrlStep2'
      })
      .when('/schengen-visa-form-step3', {
        templateUrl: 'views/schengen-visa-form-step3.html',
        controller: 'visaFormCtrlStep3'
      })
      .when('/forum', {
        templateUrl: 'views/forum.html',
        controller: 'forumCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
