app.factory('toAddTransactionService', function($firebaseArray) {
  var ref = new Firebase('https://myapp2-74981.firebaseio.com/');
  var toadd = $firebaseArray(ref);
  var toAddTransactionService = {
      all: toadd,
      get: function(toaddID){
        return toadd. $getRecord(toaddID);
      }
  };

  return toAddTransactionService;

});
