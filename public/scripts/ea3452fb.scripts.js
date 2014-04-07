"use strict";angular.module("VisaCreatorApp",["ngCookies","ngResource","ngSanitize","ngRoute","ngStorage"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/top.html",controller:"TopCtrl"}).when("/main",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/japan-visa-form-step1",{templateUrl:"views/japan-visa-form-step1.html",controller:"japanVisaFormCtrlStep1"}).when("/japan-visa-form-step2",{templateUrl:"views/japan-visa-form-step2.html",controller:"japanVisaFormCtrlStep2"}).when("/japan-visa-form-step3",{templateUrl:"views/japan-visa-form-step3.html",controller:"japanVisaFormCtrlStep3"}).otherwise({redirectTo:"/"})}]),angular.module("VisaCreatorApp").controller("japanVisaFormCtrlStep1",["$rootScope","$scope","japanVisaService","$location","$localStorage",function(a,b,c,d,e){b.$storage=e,b.toStep2=function(){d.path("/japan-visa-form-step2")}}]).controller("japanVisaFormCtrlStep2",["$scope","japanVisaService","$location","$localStorage",function(a,b,c,d){a.$storage=d,a.toStep3=function(){c.path("/japan-visa-form-step3")}}]).controller("japanVisaFormCtrlStep3",["$scope","japanVisaService","$location","$localStorage","$rootScope",function(a,b,c,d,e){a.$storage=d,a.downloadJapanVisaForm=function(){e.loggedIn===!1?$("#LoginModal").modal():$("#saveModal").modal()},a.downloadNow=function(c){console.log(a.store);var d=b.saveSteps(a.$storage.user,c);d.then(function(a){var b=document.createElement("a");b.href=a.url,b.click(),$("#saveModal").modal("hide")}).catch(function(){console.log("error to submit form")})}}]).controller("LoginCtrl",["$scope","$location","Login",function(a,b,c){c.getStatus(),a.fb_login=function(){c.fbLogin(b.url())}}]).controller("TopCtrl",["$scope","$localStorage",function(){}]).controller("MainCtrl",["$scope","japanVisaService",function(a){a.id=1,a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}]),angular.module("VisaCreatorApp").factory("japanVisaService",["$resource","$location",function(a){var b={},c=function(c){return a("/api/japan/form").save({userinfo:b,store:c}).$promise};return{saveSteps:function(a,d){for(var e in a)"gender"===e?"male"===a[e]?b.genderMale="X":"female"===a[e]&&(b.genderFemale="X"):"martialStatus"===e?"single"===a[e]?b.martialStatusSingle="X":"married"===a[e]?b.martialStatusMarried="X":"widowed"===a[e]?b.martialStatusWidowed="X":"divorced"===a[e]&&(b.martialStatusDivorced="X"):"passportType"===e?"diplomatic"===a[e]?b.passportTypeDiplomatic="X":"official"===a[e]?b.passportTypeOfficial="X":"ordinary"===a[e]?b.passportTypeOrdinary="X":"other"===a[e]&&(b.passportTypeOther="X"):"crime"===e?"yes"===a[e]?b.crimeYes="X":"no"===a[e]&&(b.crimeNo="X"):"sentenced"===e?"yes"===a[e]?b.sentencedYes="X":"no"===a[e]&&(b.sentencedNo="X"):"overstay"===e?"yes"===a[e]?b.overstayYes="X":"no"===a[e]&&(b.overstayNo="X"):"drug"===e?"yes"===a[e]?b.drugYes="X":"no"===a[e]&&(b.drugNo="X"):"prostitution"===e?"yes"===a[e]?b.prostitutionYes="X":"no"===a[e]&&(b.prostitutionNo="X"):"trafficking"===e?"yes"===a[e]?b.traffickingYes="X":"no"===a[e]&&(b.traffickingNo="X"):"guarantorGender"===e?"male"===a[e]?b.guarantorGenderMale="X":"female"===a[e]&&(b.guarantorGenderFemale="X"):"inviterGender"===e?"male"===a[e]?b.inviterGenderMale="X":"female"===a[e]&&(b.inviterGenderFemale="X"):b[e]=a[e];return c(d)}}}]),angular.module("VisaCreatorApp").factory("Login",["$http","$rootScope","$location",function(a,b){return{fbLogin:function(b){a.post("/auth/whereami",{location:b}).success(function(){var a=document.createElement("a");a.href="/auth/facebook/authenticate",a.click()}).error(function(){console.log("failed to login")})},getStatus:function(){a({method:"GET",url:"/api/login/status"}).success(function(a){console.log(a),"true"===a.login?(b.loggedIn=!0,b.first_name=a.first_name):(b.loggedIn=!1,b.first_name="")}).error(function(){b.loggedIn=!1,b.first_name=""})}}}]);