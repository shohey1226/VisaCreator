'use strict';

angular.module('VisaCreatorApp')
.factory('japanVisaService', function ($http, $rootScope, $q) {
  return {
    post: function(user){
      console.log(user);
    },
    get: function(){

    }
  }
});

