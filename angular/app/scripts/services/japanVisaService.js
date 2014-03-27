'use strict';

angular.module('VisaCreatorApp')
.factory('japanVisaService', function ($resource) {

  return {
    saveForm: function(user){
      $resource('/api/japan/form').save(user);
    },
    downloadForm: function(id){
      $resource('/api/japan/form/download/' + id).query();
    },
    get: function(){
    }
  }
});

