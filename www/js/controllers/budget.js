angular.module('starter')

  .controller("BudgetCtrl", ['$scope','$state','$http',
    function($scope,$state,$http)
    {

      $http.get('js/categories.json').success (function(data){
        $scope.categoryVariable = data;
        $scope.orderCategory = 'budget';
      });

      //$scope.goToCategory = (function(str) {
      //  categoryVariable = str;
      //  $state.go('app.category');
      //});

    }]
  );
