'use strict';

angular.module('VisaCreatorApp')
.factory('japanVisaService', function ($resource, $location) {

  var userInfo = {};
  var timestamp; 

  var _submitForm = function(){
    return $resource('/api/japan/form').save(userInfo).$promise;
  };

  return {
    // Save form in Step1
    saveStep1: function(user){
      for (var key in user){
        // Need to have logic for selections
        if (key === 'gender'){
          if (user[key] === 'male'){
            userInfo['genderMale'] = "Y";
          }else if (user[key] === 'female'){
            userInfo['genderFemale'] = "Y";
          } 
        } 
        else if (key === 'martialStatus'){
          if (user[key] === 'single'){ userInfo['martialStatusSingle'] = 'Y'}
          else if (user[key] === 'married'){ userInfo['martialStatusMarried'] = 'Y'}
          else if (user[key] === 'widowed'){ userInfo['martialStatusWidowed'] = 'Y' }
          else if (user[key] === 'divorced'){ userInfo['martialStatusDivorced'] = 'Y'}

        } else if (key === 'passportType'){
          if (user[key] === 'diplomatic'){ userInfo['passportTypeDiplomatic'] = 'Y'}
          else if (user[key] === 'official'){ userInfo['passportTypeOfficial'] = 'Y'}
          else if (user[key] === 'ordinary'){ userInfo['passportTypeOrdinary'] = 'Y' }
          else if (user[key] === 'other'){ userInfo['passportTypeOther'] = 'Y' }

        } else if (key === 'crime'){ 
          if (user[key] === 'yes'){ userInfo['crimeYes'] = 'Y'}
          else if (user[key] === 'no'){ userInfo['crimeNo'] = 'Y'}

        } else if (key === 'sentenced'){
          if (user[key] === 'yes'){ userInfo['sentencedYes'] = 'Y'}
          else if (user[key] === 'no'){ userInfo['sentencedNo'] = 'Y'}

        } else if (key === 'overstay'){
          if (user[key] === 'yes'){ userInfo['overstayYes'] = 'Y'}
          else if (user[key] === 'no'){ userInfo['overstayNo'] = 'Y'}

        } else if (key === 'drug'){
          if (user[key] === 'yes'){ userInfo['drugYes'] = 'Y'}
          else if (user[key] === 'no'){ userInfo['drugNo'] = 'Y'}

        } else if (key === 'prostitution'){
          if (user[key] === 'yes'){ userInfo['prostitutionYes'] = 'Y'}
          else if (user[key] === 'no'){ userInfo['prostitutionNo'] = 'Y'}

        } else if (key === 'trafficking'){
          if (user[key] === 'yes'){ userInfo.traffickingYes = 'Y'}
          else if (user[key] === 'no'){ userInfo.traffickingNo = 'Y'}
        }
        else{
          userInfo[key] = user[key];
        }
      }
      console.log(userInfo);
    },
    // Save from in Step2
    saveStep2: function(user){
      for (var key in user){
        userInfo[key] = user[key];
      }
      console.log(userInfo);
    },
    // Save from in Step3
    saveStep3: function(user){
      for (var key in user){
        if (key === 'guarantorGender'){
          if (user[key] === 'male'){
            userInfo.guarantorGenderMale = "Y";
          }else if (user[key] === 'female'){
            userInfo.guarantorGenderFemale = "Y";
          } 
        }
        else if (key === 'inviterGender'){
          if (user[key] === 'male'){
            userInfo.inviterGenderMale = "Y";
          }else if (user[key] === 'female'){
            userInfo.inviterGenderFemale = "Y";
          } 
        }
        else{
          userInfo[key] = user[key];
        }
      }
      console.log(userInfo);
      return _submitForm();
    }
  }
});

