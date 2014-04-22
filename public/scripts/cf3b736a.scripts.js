"use strict";angular.module("VisaCreatorApp",["ngCookies","ngResource","ngSanitize","ngRoute","ngStorage"]).config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/top.html",controller:"TopCtrl"}).when("/main",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/japan-visa-form-step1",{templateUrl:"views/japan-visa-form-step1.html",controller:"visaFormCtrlStep1"}).when("/japan-visa-form-step2",{templateUrl:"views/japan-visa-form-step2.html",controller:"visaFormCtrlStep2"}).when("/japan-visa-form-step3",{templateUrl:"views/japan-visa-form-step3.html",controller:"visaFormCtrlStep3"}).when("/schengen-visa-form-step1",{templateUrl:"views/schengen-visa-form-step1.html",controller:"visaFormCtrlStep1"}).when("/schengen-visa-form-step2",{templateUrl:"views/schengen-visa-form-step2.html",controller:"visaFormCtrlStep2"}).when("/schengen-visa-form-step3",{templateUrl:"views/schengen-visa-form-step3.html",controller:"visaFormCtrlStep3"}).otherwise({redirectTo:"/"})}]),angular.module("VisaCreatorApp").controller("visaFormCtrlStep1",["$scope","$location","$localStorage","$rootScope",function(a,b,c,d){a.$storage=c,a.toStep2=function(){b.path("/"+d.targetVisa+"-visa-form-step2")}}]).controller("visaFormCtrlStep2",["$scope","$location","$localStorage","$rootScope",function(a,b,c,d){a.$storage=c,a.toStep3=function(){b.path("/"+d.targetVisa+"-visa-form-step3")}}]).controller("visaFormCtrlStep3",["$scope","japanVisaService","schengenVisaService","$location","$localStorage","$rootScope",function(a,b,c,d,e,f){a.$storage=e,a.downloadVisaForm=function(){f.loggedIn===!1?$("#LoginModal").modal():$("#saveModal").modal()},a.downloadNow=function(d){console.log(a.store);var e;"japan"===f.targetVisa?e=b.saveSteps(a.$storage.user,d):"schengen"===f.targetVisa&&(e=c.saveSteps(a.$storage.user,d,a.$storage.country)),e.then(function(a){var b=document.createElement("a");b.href=a.url,b.click(),$("#saveModal").modal("hide")}).catch(function(){console.log("error to submit form")})}}]).controller("LoginCtrl",["$scope","$location","Login","$rootScope","japanVisaService","$localStorage",function(a,b,c,d,e,f){a.$storage=f,c.getStatus(),a.fb_login=function(){c.fbLogin(b.url())},a.twitter_login=function(){c.twitterLogin(b.url())},a.g_login=function(){c.gLogin(b.url())},a.fillin=function(){if(d.loggedIn===!0){var b=e.getInfo();b.then(function(b){a.$storage.user=b}).catch(function(){console.log("error to submit form")})}}}]).controller("TopCtrl",["$scope","$localStorage","$location","$rootScope","japanVisaService","schengenVisaService",function(a,b,c,d,e,f){a.$storage=b,a.countries=["Japan","France","Spain"],a.goStep=function(b){if("Japan"===b){if(d.targetVisa="japan",d.loggedIn===!0){var g=e.getInfo();g.then(function(b){a.$storage.user=b}).catch(function(){console.log("error to submit form")})}c.path("/japan-visa-form-step1")}else if("France"===b||"Spain"===b){if(a.$storage.country=b,a.$storage.user={},a.$storage.user.familyMember="false",a.$storage.user.existInviter="false",d.targetVisa="schengen",d.loggedIn===!0){var g=f.getInfo();g.then(function(b){a.$storage.user=b,void 0===a.$storage.user.familyMember&&(a.$storage.user.familyMember="false"),void 0===a.$storage.user.existInviter&&(a.$storage.user.existInviter="false")}).catch(function(){console.log("error to submit form")})}c.path("/schengen-visa-form-step1")}},b.$reset()}]).controller("MainCtrl",function(a){a.id=1,a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}),angular.module("VisaCreatorApp").factory("japanVisaService",["$resource","$location",function(a){return{saveSteps:function(b,c){var d={};for(var e in b)console.log(b[e]),"gender"===e?"male"===b[e]?d.genderMale="X":"female"===b[e]&&(d.genderFemale="X"):"martialStatus"===e?"single"===b[e]?d.martialStatusSingle="X":"married"===b[e]?d.martialStatusMarried="X":"widowed"===b[e]?d.martialStatusWidowed="X":"divorced"===b[e]&&(d.martialStatusDivorced="X"):"passportType"===e?"diplomatic"===b[e]?d.passportTypeDiplomatic="X":"official"===b[e]?d.passportTypeOfficial="X":"ordinary"===b[e]?d.passportTypeOrdinary="X":"other"===b[e]&&(d.passportTypeOther="X"):"crime"===e?"yes"===b[e]?d.crimeYes="X":"no"===b[e]&&(d.crimeNo="X"):"sentenced"===e?"yes"===b[e]?d.sentencedYes="X":"no"===b[e]&&(d.sentencedNo="X"):"overstay"===e?"yes"===b[e]?d.overstayYes="X":"no"===b[e]&&(d.overstayNo="X"):"drug"===e?"yes"===b[e]?d.drugYes="X":"no"===b[e]&&(d.drugNo="X"):"prostitution"===e?"yes"===b[e]?d.prostitutionYes="X":"no"===b[e]&&(d.prostitutionNo="X"):"trafficking"===e?"yes"===b[e]?d.traffickingYes="X":"no"===b[e]&&(d.traffickingNo="X"):"guarantorGender"===e?"male"===b[e]?d.guarantorGenderMale="X":"female"===b[e]&&(d.guarantorGenderFemale="X"):"inviterGender"===e?"male"===b[e]?d.inviterGenderMale="X":"female"===b[e]&&(d.inviterGenderFemale="X"):d[e]=b[e];return a("/api/japan/form").save({userinfo:d,store:c}).$promise},getInfo:function(){return a("/api/japan/form").get().$promise}}}]),angular.module("VisaCreatorApp").factory("schengenVisaService",["$resource","$location",function(a){return{saveSteps:function(b,c,d){var e={};for(var f in b)console.log(b[f]),"gender"===f?"male"===b[f]?e.genderMale="X":"female"===b[f]&&(e.genderFemale="X"):"martialStatus"===f?"single"===b[f]?e.martialStatusSingle="X":"married"===b[f]?e.martialStatusMarried="X":"widowed"===b[f]?e.martialStatusWidowed="X":"separated"===b[f]?e.martialStatusSeparated="X":"divorced"===b[f]?e.martialStatusDivorced="X":"other"===b[f]&&(e.martialStatusOther="X"):"passportType"===f?"diplomatic"===b[f]?e.passportTypeDiplomatic="X":"official"===b[f]?e.passportTypeOfficial="X":"service"===b[f]?e.passportTypeService="X":"special"===b[f]?e.passportTypeSpecial="X":"ordinary"===b[f]?e.passportTypeOrdinary="X":"other"===b[f]&&(e.passportTypeOther="X"):"numOfEntries"===f?"single"===b[f]?e.numOfEntriesSingle="X":"two"===b[f]?e.numOfEntriesTwo="X":"multiple"===b[f]&&(e.numOfEntriesMultiple="X"):"otherResidence"===f?"yes"===b[f]?e.otherResidenceYes="X":"no"===b[f]&&(e.otherResidenceNo="X"):"purpose"===f?"tourism"===b[f]?e.purposeTourism="X":"business"===b[f]?e.purposeBusiness="X":"visiting"===b[f]?e.purposeVisiting="X":"cultural"===b[f]?e.purposeCultural="X":"sports"===b[f]?e.purposeSports="X":"official"===b[f]?e.purposeOfficial="X":"study"===b[f]?e.purposeStudy="X":"medical"===b[f]?e.purposeMedical="X":"transit"===b[f]?e.purposeTransit="X":"airportTransit"===b[f]?e.purposeAirportTransit="X":"other"===b[f]&&(e.purposeOther="X"):"visaPast"===f?"no"===b[f]?e.visaPastNo="X":"yes"===b[f]&&(e.visaPastYes="X"):"fingerprints"===f?"no"===b[f]?e.fingerprintsNo="X":"yes"===b[f]&&(e.fingerprintsYes="X"):"byMyself"===f?b[f]&&(e.byMyself="X"):"byMyselfCash"===f?b[f]&&(e.byMyselfCash="X"):"byMyselfTC"===f?b[f]&&(e.byMyselfTC="X"):"byMyselfCC"===f?b[f]&&(e.byMyselfCC="X"):"byMyselfPreAcco"===f?b[f]&&(e.byMyselfPreAcco="X"):"byMyselfPreTrans"===f?b[f]&&(e.byMyselfPreTrans="X"):"byMyselfOther"===f?b[f]&&(e.byMyselfOther="X"):"bySponsor"===f?b[f]&&(e.bySponsor="X"):"bySponsor3132"===f?b[f]&&(e.bySponsor3132="X"):"bySponsorCash"===f?b[f]&&(e.bySponsorCash="X"):"bySponsorAcco"===f?b[f]&&(e.bySponsorAcco="X"):"bySponsorCovered"===f?b[f]&&(e.bySponsorCovered="X"):"bySponsorPreTrans"===f?b[f]&&(e.bySponsorPreTrans="X"):"bySponsorOther"===f?b[f]&&(e.bySponsorOther="X"):"bySponsorMeansOther"===f?b[f]&&(e.bySponsorMeansOther="X"):"schengenFamilyRelation"===f?"spouse"===b[f]?e.schengenFamilyRelationSpouse="X":"child"===b[f]?e.schengenFamilyRelationChild="X":"grandchild"===b[f]?e.schengenFamilyRelationGrandchild="X":"dependent"===b[f]&&(e.schengenFamilyRelationDependent="X"):e[f]=b[f];return e.country=d,a("/api/schengen/form").save({userinfo:e,store:c}).$promise},getInfo:function(){return a("/api/schengen/form").get().$promise}}}]),angular.module("VisaCreatorApp").factory("Login",["$http","$rootScope","$location",function(a,b){return{twitterLogin:function(b){a.post("/auth/whereami",{location:b}).success(function(){var a=document.createElement("a");a.href="/auth/twitter/authenticate",a.click()}).error(function(){console.log("failed to login")})},gLogin:function(b){a.post("/auth/whereami",{location:b}).success(function(){var a=document.createElement("a");a.href="/auth/google/authenticate",a.click()}).error(function(){console.log("failed to login")})},fbLogin:function(b){a.post("/auth/whereami",{location:b}).success(function(){var a=document.createElement("a");a.href="/auth/facebook/authenticate",a.click()}).error(function(){console.log("failed to login")})},getStatus:function(){a({method:"GET",url:"/api/login/status"}).success(function(a){return console.log(a),"true"===a.login?(b.loggedIn=!0,b.first_name=a.first_name,!0):(b.loggedIn=!1,b.first_name="",!1)}).error(function(){return b.loggedIn=!1,b.first_name="",!1})}}}]);