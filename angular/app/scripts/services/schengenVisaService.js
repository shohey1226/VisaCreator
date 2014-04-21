'use strict';

angular.module('VisaCreatorApp')
.factory('schengenVisaService', function ($resource, $location) {

  return {
    // Save form in Steps
    saveSteps: function(user, store, country){
      var userInfo = {};
      for (var key in user){
          console.log(user[key]);
        // Need to have logic for selections
        if (key === 'gender'){
          if (user[key] === 'male'){
            userInfo.genderMale = "X";
          }else if (user[key] === 'female'){
            userInfo.genderFemale = "X";
          } 
        } 
        else if (key === 'martialStatus'){

          if (user[key] === 'single'){ 
              userInfo.martialStatusSingle = 'X';
          }
          else if (user[key] === 'married'){ 
              userInfo.martialStatusMarried = 'X';
          }
          else if (user[key] === 'widowed'){ 
              userInfo.martialStatusWidowed = 'X'; 
          }
          else if (user[key] === 'separated'){ 
              userInfo.martialStatusSeparated = 'X'; 
          }
          else if (user[key] === 'divorced'){ 
              userInfo.martialStatusDivorced = 'X'
          }
          else if (user[key] === 'other'){ 
              userInfo.martialStatusOther = 'X'
          }

        } else if (key === 'passportType'){

          if (user[key] === 'diplomatic'){ 
              userInfo.passportTypeDiplomatic = 'X';
          }
          else if (user[key] === 'official'){ 
              userInfo.passportTypeOfficial = 'X';
          }
          else if (user[key] === 'service'){ 
              userInfo.passportTypeService = 'X';
          }
          else if (user[key] === 'special'){ 
              userInfo.passportTypeSpecial = 'X';
          }
          else if (user[key] === 'ordinary'){ 
              userInfo.passportTypeOrdinary = 'X';
          }
          else if (user[key] === 'other'){ 
              userInfo.passportTypeOther = 'X';
          }

        } else if (key === 'numOfEntries'){

          if (user[key] === 'single'){ 
              userInfo.numOfEntriesSingle = 'X';
          }
          else if (user[key] === 'two'){ 
              userInfo.numOfEntriesTwo = 'X';
          }
          else if (user[key] === 'multiple'){ 
              userInfo.numOfEntriesMultiple = 'X';
          }

        } else if (key === 'otherResidence'){

          if (user[key] === 'yes'){ 
              userInfo.otherResidenceYes = 'X';
          }
          else if (user[key] === 'no'){ 
              userInfo.otherResidenceNo = 'X';
          }
        } else if (key === 'purpose'){

          if (user[key] === 'tourism'){ 
              userInfo.purposeTourism = 'X';
          }
          else if (user[key] === 'business'){ 
              userInfo.purposeBusiness = 'X';
          }
          else if (user[key] === 'visiting'){ 
              userInfo.purposeVisiting = 'X';
          }
          else if (user[key] === 'cultural'){ 
              userInfo.purposeCultural = 'X';
          }
          else if (user[key] === 'sports'){ 
              userInfo.purposeSports = 'X';
          }
          else if (user[key] === 'official'){ 
              userInfo.purposeOfficial = 'X';
          }
          else if (user[key] === 'study'){ 
              userInfo.purposeStudy = 'X';
          }
          else if (user[key] === 'medical'){ 
              userInfo.purposeMedical = 'X';
          }
          else if (user[key] === 'transit'){ 
              userInfo.purposeTransit = 'X';
          }
          else if (user[key] === 'airportTransit'){ 
              userInfo.purposeAirportTransit = 'X';
          }
          else if (user[key] === 'other'){ 
              userInfo.purposeOther = 'X';
          }
        } else if (key === 'visaPast'){ 
          if (user[key] === 'no'){ 
              userInfo.visaPastNo = 'X';
          }
          else if (user[key] === 'yes'){ 
              userInfo.visaPastYes = 'X';
          }

        } else if (key === 'fingerprints'){ 
          if (user[key] === 'no'){ 
              userInfo.fingerprintsNo = 'X';
          }
          else if (user[key] === 'yes'){ 
              userInfo.fingerprintsYes = 'X';
          }

        } else if (key === 'byMyself'){ 
          if (user[key]){ 
              userInfo.byMyself = 'X';
          }

        } else if (key === 'byMyselfCash'){ 
          if (user[key]){ 
              userInfo.byMyselfCash = 'X';
          }

        } else if (key === 'byMyselfTC'){ 
          if (user[key]){ 
              userInfo.byMyselfTC = 'X';
          }
          
        } else if (key === 'byMyselfCC'){ 
          if (user[key]){ 
              userInfo.byMyselfCC = 'X';
          }

        } else if (key === 'byMyselfPreAcco'){ 
          if (user[key]){ 
              userInfo.byMyselfPreAcco = 'X';
          }

        } else if (key === 'byMyselfPreTrans'){ 
          if (user[key]){ 
              userInfo.byMyselfPreTrans = 'X';
          }

        } else if (key === 'byMyselfOther'){ 
          if (user[key]){ 
              userInfo.byMyselfOther = 'X';
          }

        } else if (key === 'bySponsor'){ 
          if (user[key]){ 
              userInfo.bySponsor = 'X';
          }

        } else if (key === 'bySponsor3132'){ 
          if (user[key]){ 
              userInfo.bySponsor3132 = 'X';
          }

        } else if (key === 'bySponsorCash'){ 
          if (user[key]){ 
              userInfo.bySponsorCash = 'X';
          }

        } else if (key === 'bySponsorAcco'){ 
          if (user[key]){ 
              userInfo.bySponsorAcco = 'X';
          }

        } else if (key === 'bySponsorCovered'){ 
          if (user[key]){ 
              userInfo.bySponsorCovered = 'X';
          }

        } else if (key === 'bySponsorPreTrans'){ 
          if (user[key]){ 
              userInfo.bySponsorPreTrans = 'X';
          }

        } else if (key === 'bySponsorOther'){ 
          if (user[key]){ 
              userInfo.bySponsorOther = 'X';
          }

        } else if (key === 'bySponsorMeansOther'){ 
          if (user[key]){ 
              userInfo.bySponsorMeansOther = 'X';
          }
          
        } else if (key === 'schengenFamilyRelation'){ 
          if (user[key] === 'spouse'){ 
              userInfo.schengenFamilyRelationSpouse = 'X';
          }
          else if (user[key] === 'child'){
              userInfo.schengenFamilyRelationChild = 'X';
          }
          else if (user[key] === 'grandchild'){
              userInfo.schengenFamilyRelationGrandchild = 'X';
          }
          else if (user[key] === 'dependent'){
              userInfo.schengenFamilyRelationDependent = 'X';
          }

        } else{
          userInfo[key] = user[key];
        }
      }
      userInfo.country = country;
      return $resource('/api/schengen/form').save({userinfo: userInfo, store: store}).$promise;
    },
    getInfo: function (){
        return $resource('/api/schengen/form').get().$promise;
    }
  }
});

