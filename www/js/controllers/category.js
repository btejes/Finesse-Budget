angular.module('starter')

  .controller("CategoriesCtrl", ['$scope','$http','$stateParams', 'transactions', 'categories',
    function($scope, $http, $stateParams, transactions, categories)
    {

      categories.getCategories().success(function(data) {
        $scope.categoryVariable = data;
        $scope.whichCategory = $stateParams.categoryId;
      });

      transactions.getTransactionsByCategory($stateParams.categoryId).then(function(data) {
        $scope.transactionVariable = data;
      });

    }]
  );
