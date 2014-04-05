'use strict';

angular.module('VisaCreatorApp')
.factory('Login', ['$http', '$rootScope', '$location', function ($http, $rootScope, $location) {

    return {
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
                    }else{
                        $rootScope.loggedIn = false;
                        $rootScope.first_name = ''; 
                    }
                }).
                error(function(data, status, headers, config) {
                    $rootScope.loggedIn = false;
                    $rootScope.first_name = ''; 
                });
        }
    }
}]);
