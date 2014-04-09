"use strict";angular.module("VisaCreatorApp",["ngCookies","ngResource","ngSanitize","ngRoute","ngStorage"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/top.html",controller:"TopCtrl"}).when("/main",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/japan-visa-form-step1",{templateUrl:"views/japan-visa-form-step1.html",controller:"japanVisaFormCtrlStep1"}).when("/japan-visa-form-step2",{templateUrl:"views/japan-visa-form-step2.html",controller:"japanVisaFormCtrlStep2"}).when("/japan-visa-form-step3",{templateUrl:"views/japan-visa-form-step3.html",controller:"japanVisaFormCtrlStep3"}).otherwise({redirectTo:"/"})}]),angular.module("VisaCreatorApp").controller("japanVisaFormCtrlStep1",["$rootScope","$scope","japanVisaService","$location","$localStorage",function(a,b,c,d,e){b.$storage=e,b.toStep2=function(){d.path("/japan-visa-form-step2")}}]).controller("japanVisaFormCtrlStep2",["$scope","japanVisaService","$location","$localStorage",function(a,b,c,d){a.$storage=d,a.toStep3=function(){c.path("/japan-visa-form-step3")}}]).controller("japanVisaFormCtrlStep3",["$scope","japanVisaService","$location","$localStorage","$rootScope",function(a,b,c,d,e){a.$storage=d,a.downloadJapanVisaForm=function(){e.loggedIn===!1?$("#LoginModal").modal():$("#saveModal").modal()},a.downloadNow=function(c){console.log(a.store);var d=b.saveSteps(a.$storage.user,c);d.then(function(a){var b=document.createElement("a");b.href=a.url,b.click(),$("#saveModal").modal("hide")}).catch(function(){console.log("error to submit form")})}}]).controller("LoginCtrl",["$scope","$location","Login","$rootScope","japanVisaService","$localStorage",function(a,b,c,d,e,f){a.$storage=f,c.getStatus(),a.fb_login=function(){c.fbLogin(b.url())},a.twitter_login=function(){c.twitterLogin(b.url())},a.g_login=function(){c.gLogin(b.url())},a.fillin=function(){if(d.loggedIn===!0){var b=e.getInfo();b.then(function(b){a.$storage.user=b}).catch(function(){console.log("error to submit form")})}}}]).controller("TopCtrl",["$scope","$localStorage","$location","$rootScope","japanVisaService",function(a,b,c,d,e){a.$storage=b,a.goStep=function(b){if("japan"===b){if(d.loggedIn===!0){var f=e.getInfo();f.then(function(b){a.$storage.user=b}).catch(function(){console.log("error to submit form")})}c.path("/japan-visa-form-step1")}},b.$reset()}]).controller("MainCtrl",["$scope","japanVisaService",function(a){a.id=1,a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("VisaCreatorApp").factory("japanVisaService",["$resource","$location",function(a){return{saveSteps:function(b,c){var d={};for(var e in b)console.log(b[e]),"gender"===e?"male"===b[e]?d.genderMale="X":"female"===b[e]&&(d.genderFemale="X"):"martialStatus"===e?"single"===b[e]?d.martialStatusSingle="X":"married"===b[e]?d.martialStatusMarried="X":"widowed"===b[e]?d.martialStatusWidowed="X":"divorced"===b[e]&&(d.martialStatusDivorced="X"):"passportType"===e?"diplomatic"===b[e]?d.passportTypeDiplomatic="X":"official"===b[e]?d.passportTypeOfficial="X":"ordinary"===b[e]?d.passportTypeOrdinary="X":"other"===b[e]&&(d.passportTypeOther="X"):"crime"===e?"yes"===b[e]?d.crimeYes="X":"no"===b[e]&&(d.crimeNo="X"):"sentenced"===e?"yes"===b[e]?d.sentencedYes="X":"no"===b[e]&&(d.sentencedNo="X"):"overstay"===e?"yes"===b[e]?d.overstayYes="X":"no"===b[e]&&(d.overstayNo="X"):"drug"===e?"yes"===b[e]?d.drugYes="X":"no"===b[e]&&(d.drugNo="X"):"prostitution"===e?"yes"===b[e]?d.prostitutionYes="X":"no"===b[e]&&(d.prostitutionNo="X"):"trafficking"===e?"yes"===b[e]?d.traffickingYes="X":"no"===b[e]&&(d.traffickingNo="X"):"guarantorGender"===e?"male"===b[e]?d.guarantorGenderMale="X":"female"===b[e]&&(d.guarantorGenderFemale="X"):"inviterGender"===e?"male"===b[e]?d.inviterGenderMale="X":"female"===b[e]&&(d.inviterGenderFemale="X"):d[e]=b[e];return a("/api/japan/form").save({userinfo:d,store:c}).$promise},getInfo:function(){return a("/api/japan/form").get().$promise}}}]),angular.module("VisaCreatorApp").factory("Login",["$http","$rootScope","$location",function(a,b){return{twitterLogin:function(b){a.post("/auth/whereami",{location:b}).success(function(){var a=document.createElement("a");a.href="/auth/twitter/authenticate",a.click()}).error(function(){console.log("failed to login")})},gLogin:function(b){a.post("/auth/whereami",{location:b}).success(function(){var a=document.createElement("a");a.href="/auth/google/authenticate",a.click()}).error(function(){console.log("failed to login")})},fbLogin:function(b){a.post("/auth/whereami",{location:b}).success(function(){var a=document.createElement("a");a.href="/auth/facebook/authenticate",a.click()}).error(function(){console.log("failed to login")})},getStatus:function(){a({method:"GET",url:"/api/login/status"}).success(function(a){return console.log(a),"true"===a.login?(b.loggedIn=!0,b.first_name=a.first_name,!0):(b.loggedIn=!1,b.first_name="",!1)}).error(function(){return b.loggedIn=!1,b.first_name="",!1})}}}]);