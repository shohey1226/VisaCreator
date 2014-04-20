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


        } else if (key === 'crime'){ 
          if (user[key] === 'yes'){ 
              userInfo.crimeYes = 'X';
          }
          else if (user[key] === 'no'){ 
              userInfo.crimeNo = 'X';
          }

        } else if (key === 'sentenced'){
          if (user[key] === 'yes'){ 
              userInfo.sentencedYes = 'X';
          }
          else if (user[key] === 'no'){ 
              userInfo.sentencedNo = 'X';
          }

        } else if (key === 'overstay'){
          if (user[key] === 'yes'){ 
              userInfo.overstayYes = 'X';
          }
          else if (user[key] === 'no'){ 
              userInfo.overstayNo = 'X';
          }

        } else if (key === 'drug'){
          if (user[key] === 'yes'){ 
              userInfo.drugYes = 'X';
          }
          else if (user[key] === 'no'){ 
              userInfo.drugNo = 'X';
          }

        } else if (key === 'prostitution'){
          if (user[key] === 'yes'){ 
              userInfo.prostitutionYes = 'X';
          }
          else if (user[key] === 'no'){ 
              userInfo.prostitutionNo = 'X';
          }

        } else if (key === 'trafficking'){
          if (user[key] === 'yes'){ 
              userInfo.traffickingYes = 'X';
          }
          else if (user[key] === 'no'){ 
              userInfo.traffickingNo = 'X';
          }
        }
        else if (key === 'guarantorGender'){
          if (user[key] === 'male'){
            userInfo.guarantorGenderMale = "X";
          }else if (user[key] === 'female'){
            userInfo.guarantorGenderFemale = "X";
          } 
        }
        else if (key === 'inviterGender'){
          if (user[key] === 'male'){
            userInfo.inviterGenderMale = "X";
          }else if (user[key] === 'female'){
            userInfo.inviterGenderFemale = "X";
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

