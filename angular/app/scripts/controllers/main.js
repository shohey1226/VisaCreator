'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrlStep1', function ($rootScope, $scope, japanVisaService, $location, $localStorage) {

    $scope.$storage = $localStorage;
    $scope.toStep2 = function(){
      $location.path('/japan-visa-form-step2');
    };
  })
  .controller('japanVisaFormCtrlStep2', function ($scope, japanVisaService, $location, $localStorage) {

    $scope.$storage = $localStorage;
    $scope.toStep3 = function(){
      $location.path('/japan-visa-form-step3');
    };
  })
  .controller('japanVisaFormCtrlStep3', function ($scope, japanVisaService, $location, $localStorage, $rootScope) {

    $scope.$storage = $localStorage;
    $scope.downloadJapanVisaForm = function(){
      if ($rootScope.loggedIn === false){
        $('#LoginModal').modal();
      } else {
        $('#saveModal').modal();  
      }
    };

    $scope.downloadNow = function(store){
      console.log($scope.store);
      var promise = japanVisaService.saveSteps($scope.$storage.user, store);
      promise.then(function(res)  { 
        var a = document.createElement('a');
        a.href = res.url;
        a.click();
        $('#saveModal').modal('hide');
        //$location.path("/");
      })
      .catch(function(req) { console.log("error to submit form"); })
    };

  })
  //==========================================================
  // Login
  .controller('LoginCtrl', function($scope, $location, Login, $rootScope, japanVisaService, $localStorage){
    $scope.$storage = $localStorage;

    Login.getStatus()

    $scope.fb_login = function(){
        Login.fbLogin($location.url());
    }

    $scope.twitter_login = function(){
        Login.twitterLogin($location.url());
    }

    $scope.g_login = function(){
        Login.gLogin($location.url());
    }

    $scope.fillin = function(){
       if ( $rootScope.loggedIn === true ){
           var promise = japanVisaService.getInfo();
           promise.then(function(res)  { 
               $scope.$storage.user = res;
           })
           .catch(function(req) { console.log("error to submit form"); })
       }
    }

  })
  //==========================================================
  .controller('TopCtrl', function ($scope, $localStorage, $location, $rootScope, japanVisaService) {
      $scope.$storage = $localStorage;
      
      $scope.goStep = function(country){
          if (country === 'japan'){ 
              if ( $rootScope.loggedIn === true ){
                  var promise = japanVisaService.getInfo();
                  promise.then(function(res)  { 
                      $scope.$storage.user = res;
                  })
                  .catch(function(req) { console.log("error to submit form"); })
              }
              $location.path('/japan-visa-form-step1');
          }
      };
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
