'use strict';

angular.module('VisaCreatorApp')
.factory('Login', ['$http', '$rootScope', '$location', function ($http, $rootScope, $location) {

    return {
        
        twitterLogin: function(url){
            $http.post('/auth/whereami', {location: url}).
            success(function(data, status, headers, config){
                var a = document.createElement('a');
                a.href = '/auth/twitter/authenticate'; 
                a.click();
            }).
            error(function(data, status, headers, config) {
                console.log("failed to login");
            });
        },

        gLogin: function(url){
            $http.post('/auth/whereami', {location: url}).
            success(function(data, status, headers, config){
                var a = document.createElement('a');
                a.href = '/auth/google/authenticate'; 
                a.click();
            }).
            error(function(data, status, headers, config) {
                console.log("failed to login");
            });
        },

        fbLogin: function(url){
            $http.post('/auth/whereami', {location: url}).
            success(function(data, status, headers, config){
                var a = document.createElement('a');
                a.href = '/auth/facebook/authenticate'; 
                a.click();
            }).
            error(function(data, status, headers, config) {
                console.log("failed to login");
            });
        },


        getStatus: function(){
            $http({ method: 'GET', url: '/api/login/status'}).
                success(function(data, status, headers, config) {
                    console.log(data);
                    if (data.login === 'true'){
                        $rootScope.loggedIn = true;
                        $rootScope.first_name = data.first_name;
                        return true;
                    }else{
                        $rootScope.loggedIn = false;
                        $rootScope.first_name = ''; 
                        return false;
                    }
                }).
                error(function(data, status, headers, config) {
                    $rootScope.loggedIn = false;
                    $rootScope.first_name = ''; 
                    return false;
                });
        }
    }
}]);
