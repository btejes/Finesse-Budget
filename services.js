angular.module('starter.services', ['firebase'])

.factory('toAddTransactionService', function($firebaseArray) {
  var ref = new Firebase('https://myapp2-74981.firebaseio.com/');

  var toAdd = $firebaseArray(ref);

  var toAddTransactionService = {
      all: toAdd,
      get: function(toAddID){
        return toAdd.$getRecord(toAddID);
      }
  }

  return toAddTransactionService;

});

