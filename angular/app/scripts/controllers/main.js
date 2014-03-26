'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrl', function ($scope, japanVisaService) {
    $scope.save = function(user){
      japanVisaService.saveForm(user);
    };
  })
  .controller('TopCtrl', function ($scope) {
      console.log("abc");
  })
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
