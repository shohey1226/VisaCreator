'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrlStep1', function ($rootScope, $scope, japanVisaService, $location, $localStorage) {

    $scope.$storage = $localStorage;
    $scope.toStep2 = function(user){
      japanVisaService.saveStep1($scope.$storage.user);
      $location.path('/japan-visa-form-step2');
    };
  })
  .controller('japanVisaFormCtrlStep2', function ($scope, japanVisaService, $location, $localStorage) {

    $scope.$storage = $localStorage;
    $scope.toStep3 = function(user){
      japanVisaService.saveStep2($scope.$storage.user);
      $location.path('/japan-visa-form-step3');
    };
  })
  .controller('japanVisaFormCtrlStep3', function ($scope, japanVisaService, $location, $localStorage) {
      
    $scope.$storage = $localStorage;
    $scope.downloadJapanVisaForm = function(user){
      var promise = japanVisaService.saveStep3($scope.$storage.user);

      promise.then(function(res)  { 
        console.log(res.url);
        var a = document.createElement('a');
        a.href = res.url;
        a.click();
        $location.path("/");
      })
      .catch(function(req) { console.log("error to submit form"); })
    };

  })
  //==========================================================
  // Login
  .controller('LoginCtrl', function($scope, $location, Login){
    Login.getStatus();
    $scope.fb_login = function(){
        Login.fbLogin($location.url());
    }
  })
  //==========================================================
  .controller('TopCtrl', function ($scope, $localStorage) {
      $localStorage.$reset();
  })
  .controller('MainCtrl', function ($scope, japanVisaService) {
    $scope.id = 1;

    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
