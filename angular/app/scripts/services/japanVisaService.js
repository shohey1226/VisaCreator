'use strict';

angular.module('VisaCreatorApp')
.factory('japanVisaService', function ($resource) {

  var userInfo;

  return {
    saveFormStep1: function(user){
      this.userInfo = user;
      // for i in user
      //user infouser.i
      //$resource('/api/japan/form').save(user);
    },
    saveFormStep2: function(user){
      //this.userInfo = user;
      //$resource('/api/japan/form').save(user);
    },
    downloadForm: function(){
      var timestamp = $resource('/api/japan/form').save(this.userInfo);
      $resource('/api/japan/form/download/' + timestamp).query();
    },
    get: function(){
    }
  }
});

