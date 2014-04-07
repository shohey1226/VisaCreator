'use strict';

angular.module('VisaCreatorApp')
.factory('japanVisaService', function ($resource, $location) {

  //var userInfo = {};
  var original_user = {};

  var _submitForm = function(store){
    return $resource('/api/japan/form').save({userinfo: userInfo, store: store}).$promise;
  };

  return {
    // Save form in Steps
    saveSteps: function(user, store){
      var userInfo = {};
      console.log(user);
      for (var key in user){
          console.log(user[key]);
        // Need to have logic for selections
        if (key === 'gender'){
          if (user[key] === 'male'){
            userInfo.genderMale = "X";
            //delete userInfo.genderFemale;
          }else if (user[key] === 'female'){
            userInfo.genderFemale = "X";
            //delete userInfo.genderMale;
          } 
        } 
        else if (key === 'martialStatus'){

          if (user[key] === 'single'){ 
              userInfo.martialStatusSingle = 'X';
              //delete userInfo.martialStatusMarried if( "martialStatusMarried" in userinfo); 
              //delete userInfo.martialStatusWidowed if ( "martialStatusWidowed" in userinfo);
              //delete userInfo.martialStatusDivorced if ( "martialStatusDivorced" in userinfo);
          }
          else if (user[key] === 'married'){ 
              userInfo.martialStatusMarried = 'X';
              //delete userInfo.martialStatusSingle;
              //delete userInfo.martialStatusWidowed;
              //delete userInfo.martialStatusDivorced;
          }
          else if (user[key] === 'widowed'){ 
              userInfo.martialStatusWidowed = 'X'; 
              //delete userInfo.martialStatusSingle;
              //delete userInfo.martialStatusMarried; 
              //delete userInfo.martialStatusDivorced;
          }
          else if (user[key] === 'divorced'){ 
              userInfo.martialStatusDivorced = 'X'
              //delete userInfo.martialStatusSingle;
              //delete userInfo.martialStatusMarried; 
              //delete userInfo.martialStatusWidowed;
          }

        } else if (key === 'passportType'){

          if (user[key] === 'diplomatic'){ 
              userInfo.passportTypeDiplomatic = 'X';
              //delete userInfo.passportTypeOfficial;
              //delete userInfo.passportTypeOrdinary; 
              //delete userInfo.passportTypeOther;
          }
          else if (user[key] === 'official'){ 
              userInfo.passportTypeOfficial = 'X';
              //delete userInfo.passportTypeDiplomatic;
              //delete userInfo.passportTypeOrdinary; 
              //delete userInfo.passportTypeOther;
          }
          else if (user[key] === 'ordinary'){ 
              userInfo.passportTypeOrdinary = 'X';
              //delete userInfo.passportTypeOfficial;
              //delete userInfo.passportTypeDiplomatic;
              //delete userInfo.passportTypeOther;
          }
          else if (user[key] === 'other'){ 
              userInfo.passportTypeOther = 'X';
              //delete userInfo.passportTypeOfficial;
              //delete userInfo.passportTypeDiplomatic;
              //delete userInfo.passportTypeOrdinary; 
          }

        } else if (key === 'crime'){ 
          if (user[key] === 'yes'){ 
              userInfo.crimeYes = 'X';
              //delete userInfo.crimeNo;
          }
          else if (user[key] === 'no'){ 
              userInfo.crimeNo = 'X';
              //delete userInfo.crimeYes;
          }

        } else if (key === 'sentenced'){
          if (user[key] === 'yes'){ 
              userInfo.sentencedYes = 'X';
              //delete userInfo.sentencedNo;
          }
          else if (user[key] === 'no'){ 
              userInfo.sentencedNo = 'X';
              //delete userInfo.sentencedYes;
          }

        } else if (key === 'overstay'){
          if (user[key] === 'yes'){ 
              userInfo.overstayYes = 'X';
              //delete userInfo.overstayNo;
          }
          else if (user[key] === 'no'){ 
              userInfo.overstayNo = 'X';
              //delete userInfo.overstayYes;
          }

        } else if (key === 'drug'){
          if (user[key] === 'yes'){ 
              userInfo.drugYes = 'X';
              //delete userInfo.drugNo;
          }
          else if (user[key] === 'no'){ 
              userInfo.drugNo = 'X';
              //delete userInfo.drugYes; 
          }

        } else if (key === 'prostitution'){
          if (user[key] === 'yes'){ 
              userInfo.prostitutionYes = 'X';
              //delete userInfo.prostitutionNo;
          }
          else if (user[key] === 'no'){ 
              userInfo.prostitutionNo = 'X';
              //delete userInfo.prostitutionYes;
          }

        } else if (key === 'trafficking'){
          if (user[key] === 'yes'){ 
              userInfo.traffickingYes = 'X';
              //delete userInfo.traffickingNo;
          }
          else if (user[key] === 'no'){ 
              userInfo.traffickingNo = 'X';
              //delete userInfo.traffickingYes;
          }
        }
        else if (key === 'guarantorGender'){
          if (user[key] === 'male'){
            userInfo.guarantorGenderMale = "X";
            //delete userInfo.guarantorGenderFemale;
          }else if (user[key] === 'female'){
            userInfo.guarantorGenderFemale = "X";
            //delete userInfo.guarantorGenderMale;
          } 
        }
        else if (key === 'inviterGender'){
          if (user[key] === 'male'){
            userInfo.inviterGenderMale = "X";
            //delete userInfo.inviterGenderFemale;
          }else if (user[key] === 'female'){
            userInfo.inviterGenderFemale = "X";
            //delete userInfo.inviterGenderMale;
          } 
        } else{
          userInfo[key] = user[key];
        }
      }
      //return _submitForm(store);
      return $resource('/api/japan/form').save({userinfo: userInfo, store: store}).$promise;
    }
  }
});

