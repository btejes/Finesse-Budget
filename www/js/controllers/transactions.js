angular.module('starter')

  .controller('TransactionsCtrl', ['$scope', '$state', 'categories', 'transactions', function($scope, $state, categories, transactions) {  // Doesn't like "toAddTransactionService"

    $scope.addTransaction = function (transactionAmount, transactionDate,transactionMerchant,transactionCategory) {
      /*$scope.appData.transactions.push({
       date: transactionDate,
       merchant:transactionMerchant,
       amount: transactionAmount,
       category:transactionCategory
       });*/

      transactions.addTransaction({
        date: transactionDate,
        merchant:transactionMerchant,
        amount: transactionAmount,
        category:transactionCategory
      }).then(function(data) {
        console.log(data);
      });

      $scope.transactionAmount = null;
      $scope.transactionDate =  null;
      $scope.transactionMerchant = null;
      $scope.transactionCategory = null;

    };

    transactions.getTransactions().success(function(data) {
      $scope.transactions = data;
    });

    categories.getCategories().success(function(data) {
      $scope.categoryOptions = data;
    });

    //Below this is not being used at the moment.

    $scope.newAddTransaction = function(){
      $scope.newAddTransaction = toAddTransactionService.all;
      $scope.newAddTransaction.$add({
        date: $scope.transactionDate,
        merchant: $scope.transactionMerchant,
        amount: $scope.transactionAmount,
        category: $scope.transactionCategory
      });

      $state.go('toAdd');

    };

    //Above this is not being used at the moment.




  }]);
