'use strict';

angular.module('VisaCreatorApp')
.factory('japanVisaService', function ($resource) {

  return {
    saveForm: function(user){
      $resource('/api/japan/form').save(user);
    },
    get: function(){
    }
  }
});

