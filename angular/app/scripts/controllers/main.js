'use strict';

angular.module('VisaCreatorApp')
  .controller('japanVisaFormCtrl', function ($scope, japanVisaService) {
    $scope.save = function(user){
      japanVisaService.post(user);
    };
  })
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
