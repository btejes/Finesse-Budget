angular.module('starter')

.controller('AppCtrl', function($scope, $ionicModal, $timeout) {

  // With the new view caching in Ionic, Controllers are only called
  // when they are recreated or on app start, instead of every page change.
  // To listen for when this page is active (for example, to refresh data),
  // listen for the $ionicView.enter event:
  //$scope.$on('$ionicView.enter', function(e) {
  //});

  /*$scope.appData = {
    transactions: [
      {date : "3/16/2017", merchant : "Walmart", amount : "$500.00", category: "Fixed Expenses", id: 1},
      {date : "3/12/2017", merchant : "Costco", amount : "$100.00", category: "Fixed Expenses", id: 1},
      {date : "3/11/2017", merchant : "McDonalds", amount : "$5.00", category: "Fixed Expenses", id: 1},
      {date : "3/23/2017", merchant : "Safeway", amount : "$35.00", category: "Daily Living", id: 2},
    ]
  };*/



// Form data for the login modal
  $scope.loginData = {};

  // Create the login modal that we will use later
  $ionicModal.fromTemplateUrl('templates/login.html', {
    scope: $scope
  }).then(function(modal) {
    $scope.modal = modal;
  });

  // Triggered in the login modal to close it
  $scope.closeLogin = function() {
    $scope.modal.hide();
  };

  // Open the login modal
  $scope.login = function() {
    $scope.modal.show();
  };

  // Perform the login action when the user submits the login form
  $scope.doLogin = function() {
    console.log('Doing login', $scope.loginData);

    // Simulate a login delay. Remove this and replace with your login
    // code if using a login system
    $timeout(function() {
      $scope.closeLogin();
    }, 1000);
  };
// End Form data for login modal




});

