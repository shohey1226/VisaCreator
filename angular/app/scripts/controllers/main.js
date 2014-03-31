'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrlStep1', function ($scope, japanVisaService, $location) {
    $scope.toStep2 = function(user){
      japanVisaService.saveStep1(user);
      $location.path('/japan-visa-form-step2');
    };
  })
  .controller('japanVisaFormCtrlStep2', function ($scope, japanVisaService, $location) {
    $scope.toStep3 = function(user){
      japanVisaService.saveStep2(user);
      $location.path('/japan-visa-form-step3');
    };
  })
  .controller('japanVisaFormCtrlStep3', function ($scope, japanVisaService, $location) {
    $scope.downloadJapanVisaForm = function(user){
      var promise = japanVisaService.saveStep3(user);
      promise.then(function(res)  { $location.path(res.url); })
      .catch(function(req) { console.log("error to submit form"); })
    };
  })
  .controller('TopCtrl', function ($scope) {
      console.log("abc");
  })
  .controller('MainCtrl', function ($scope, japanVisaService) {
    $scope.id = 1;

    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
