'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrlStep1', function ($rootScope, $scope, japanVisaService, $location, $sessionStorage) {

    // get data from $sessionStorage
    //$scope.user = $sessionStorage.user;
    $scope.user = {};
    for (var key in $sessionStorage.user){
        $scope.user.key = $sessionStorage.user.key;
    }

    // Event which is fired when fb_login runs
    $scope.$on('storeFields', function(){ 
      console.log('step1');
      var original_user = {};
      for (var key in $scope.user){ 
        if (typeof $sessionStorage.user.key === 'undefined'){
            $sessionStorage.user.key = {};
        }
        $sessionStorage.user.key =  $scope.user.key;
      }
    });
    
    $scope.toStep2 = function(user){
      japanVisaService.saveStep1(user);
      $location.path('/japan-visa-form-step2');
    };
  })
  .controller('japanVisaFormCtrlStep2', function ($scope, japanVisaService, $location, $sessionStorage) {

    // get data from $sessionStorage
    //$scope.user = $sessionStorage.user;
    $scope.user = {};
    for (var key in $sessionStorage.user){
        $scope.user.key = $sessionStorage.user.key;
    }
    // Event which is fired when fb_login runs
    //$scope.$on('storeFields', function(){ 
    //  $sessionStorage.user = $scope.user;
    //});
    $scope.$on('storeFields', function(){ 
      console.log('step2');
      var original_user = {};
      for (var key in $scope.user){ 
        if (typeof $sessionStorage.user.key === 'undefined'){
            $sessionStorage.user.key = {};
        }
        $sessionStorage.user.key =  $scope.user.key;
      }
    });

    $scope.toStep3 = function(user){
      japanVisaService.saveStep2(user);
      $location.path('/japan-visa-form-step3');
    };
  })
  .controller('japanVisaFormCtrlStep3', function ($scope, japanVisaService, $location, $sessionStorage) {

    //  $scope.$storage = $sessionStorage;
    // get data from $sessionStorage
    //$scope.user = $sessionStorage.user;
    $scope.user = {};
    console.log($sessionStorage.user);
    for (var key in $sessionStorage.user){
        $scope.user.key = $sessionStorage.user.key;
    }
    // Event which is fired when fb_login runs
    //$scope.$on('storeFields', function(){ 
    //  $sessionStorage.user = $scope.user;
    //});
    $scope.$on('storeFields', function(){ 
      console.log('step3');
      console.log($scope.user);
      for (var key in $scope.user){ 
          console.log(key);
        if (typeof $sessionStorage.user.key === 'undefined'){
            $sessionStorage.user.key = {};
        }
        $sessionStorage.user.key =  $scope.user.key;
      }
      console.log($sessionStorage.user);
    });

    $scope.downloadJapanVisaForm = function(user){
      var promise = japanVisaService.saveStep3(user);

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
  .controller('LoginCtrl', function($scope, $location, Login, $sessionStorage, $rootScope){

    Login.getStatus();
    $scope.fb_login = function(){
        $rootScope.$broadcast('storeFields');
        console.log($sessionStorage.user);
        alert('a');
        Login.fbLogin($location.url());
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
