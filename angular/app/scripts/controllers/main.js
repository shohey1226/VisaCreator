'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrlStep1', function ($scope, japanVisaService, $location, $sessionStorage) {

    //$scope.user = japanVisaService.getUser();
    $scope.user = $sessionStorage.user;
    $scope.toStep2 = function(user){
      $sessionStorage.user = user;
      japanVisaService.saveStep1(user);
      $location.path('/japan-visa-form-step2');
    };
  })
  .controller('japanVisaFormCtrlStep2', function ($scope, japanVisaService, $location) {
    $scope.user = japanVisaService.getUser();
    $scope.toStep3 = function(user){
      japanVisaService.saveStep2(user);
      $location.path('/japan-visa-form-step3');
    };
  })
  .controller('japanVisaFormCtrlStep3', function ($scope, japanVisaService, $location) {
    $scope.user = japanVisaService.getUser();
    $scope.downloadJapanVisaForm = function(user){
      var promise = japanVisaService.saveStep3(user);


      promise.then(function(res)  { 
        console.log(res.url);
        var a = document.createElement('a');
        a.href = res.url;
        a.download = "japan_visa_form.pdf";
        a.click();
        $location.path("/");
      })
      .catch(function(req) { console.log("error to submit form"); })
    };
  })
  //==========================================================
  // Login
  .controller('LoginCtrl', function($scope, $location, Login, $sessionStorage){
    Login.getStatus();
    $scope.fb_login = function(){
        $sessionStorage.user = $scope.user;
        Login.fbLogin($location.url(), $scope.user);
    }
  })
  //==========================================================
  .controller('TopCtrl', function ($scope) {
  })
  .controller('MainCtrl', function ($scope, japanVisaService) {
    $scope.id = 1;

    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
