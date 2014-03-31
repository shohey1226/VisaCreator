'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrlStep1', function ($scope, japanVisaService, $location) {
    $scope.toStep2 = function(user){
      //japanVisaService.saveForm(user);
      $location.path('/japan-visa-form-step2');
    };
  })
  .controller('japanVisaFormCtrlStep2', function ($scope, japanVisaService, $location) {
    $scope.toStep3 = function(user){
      //japanVisaService.saveForm(user);
      $location.path('/japan-visa-form-step3');
    };
  })
  .controller('japanVisaFormCtrlStep3', function ($scope, japanVisaService, $location) {
    $scope.downloadJapanVisaForm = function(){
      //download pdf here
      japanVisaService.downloadForm();
      //$location.path('
    };
  })
  .controller('TopCtrl', function ($scope) {
      console.log("abc");
  })
  .controller('MainCtrl', function ($scope, japanVisaService) {
    $scope.id = 1;
    //$scope.downloadForm = function(){
    //    japanVisaService.downloadForm(1); 
    //}

    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
