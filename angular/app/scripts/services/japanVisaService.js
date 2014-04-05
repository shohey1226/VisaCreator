'use strict';

angular.module('VisaCreatorApp')
.factory('japanVisaService', function ($resource, $location, $sessionStorage) {

  var userInfo = {};
  var original_user = {};
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
            userInfo['genderMale'] = "X";
          }else if (user[key] === 'female'){
            userInfo['genderFemale'] = "X";
          } 
        } 
        else if (key === 'martialStatus'){
          if (user[key] === 'single'){ userInfo['martialStatusSingle'] = 'X';}
          else if (user[key] === 'married'){ userInfo['martialStatusMarried'] = 'X';}
          else if (user[key] === 'widowed'){ userInfo['martialStatusWidowed'] = 'X'; }
          else if (user[key] === 'divorced'){ userInfo['martialStatusDivorced'] = 'X'}

        } else if (key === 'passportType'){
          if (user[key] === 'diplomatic'){ userInfo['passportTypeDiplomatic'] = 'X'}
          else if (user[key] === 'official'){ userInfo['passportTypeOfficial'] = 'X'}
          else if (user[key] === 'ordinary'){ userInfo['passportTypeOrdinary'] = 'X' }
          else if (user[key] === 'other'){ userInfo['passportTypeOther'] = 'X' }

        } else if (key === 'crime'){ 
          if (user[key] === 'yes'){ userInfo['crimeYes'] = 'X'}
          else if (user[key] === 'no'){ userInfo['crimeNo'] = 'X'}

        } else if (key === 'sentenced'){
          if (user[key] === 'yes'){ userInfo['sentencedYes'] = 'X'}
          else if (user[key] === 'no'){ userInfo['sentencedNo'] = 'X'}

        } else if (key === 'overstay'){
          if (user[key] === 'yes'){ userInfo['overstayYes'] = 'X'}
          else if (user[key] === 'no'){ userInfo['overstayNo'] = 'X'}

        } else if (key === 'drug'){
          if (user[key] === 'yes'){ userInfo['drugYes'] = 'X'}
          else if (user[key] === 'no'){ userInfo['drugNo'] = 'X'}

        } else if (key === 'prostitution'){
          if (user[key] === 'yes'){ userInfo['prostitutionYes'] = 'X'}
          else if (user[key] === 'no'){ userInfo['prostitutionNo'] = 'X'}

        } else if (key === 'trafficking'){
          if (user[key] === 'yes'){ userInfo.traffickingYes = 'X'}
          else if (user[key] === 'no'){ userInfo.traffickingNo = 'X'}
        }
        else{
          userInfo[key] = user[key];
        }
        original_user.key = user.key;
      }
      $sessionStorage.user = original_user;
    },
    // Save from in Step2
    saveStep2: function(user){
      for (var key in user){
        userInfo[key] = user[key];
        original_user.key = user.key;
      }
      $sessionStorage.user = original_user;
    },
    // Save from in Step3
    saveStep3: function(user){
      for (var key in user){
        if (key === 'guarantorGender'){
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
        }
        else{
          userInfo[key] = user[key];
        }
        original_user.key = user.key;
      }
      $sessionStorage.user = original_user;
      return _submitForm();
    }
  }
});

