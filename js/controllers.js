angular.module('starter.controllers', [])

.controller('AppCtrl', function($scope, $ionicModal, $timeout) {

  // With the new view caching in Ionic, Controllers are only called
  // when they are recreated or on app start, instead of every page change.
  // To listen for when this page is active (for example, to refresh data),
  // listen for the $ionicView.enter event:
  //$scope.$on('$ionicView.enter', function(e) {
  //});

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




})

// Start of Budget Controller

.controller('BudgetCtrl', function($scope) {

  $scope.goFixedExpenses = function()
  {
    $state.go('category');
  };

})

//End of Budget Control

.controller('FixedCtrl', function($scope, $stateParams) {
})


// Start of Transaction Controller

.controller('TransactionsCtrl', function($scope, $firebaseArray, $state) {  // Doesn't like "toAddTransactionService"


  $scope.transactions = [
      {date : "3/16/2017", merchant : "Walmart", amount : "$500.00", category: "FixedExpenses"},
      {date : "3/12/2017", merchant : "Costco", amount : "$100.00", category: "FixedExpenses"},
      {date : "3/11/2017", merchant : "McDonalds", amount : "$5.00", category: "FixedExpenses"}
    ];

  $scope.addTransaction = function (transactionAmount, transactionDate,transactionMerchant,transactionCategory) {
    $scope.transactions.push({
      date: transactionDate,
      merchant:transactionMerchant,
      amount: transactionAmount,
      category:transactionCategory
    });
  };

  $scope.newAddTransaction = function(){
    $scope.newAddTransaction = toAddTransactionService.all;
    $scope.newAddTransaction.$add({
      date: $scope.transactionDate,
      merchant: $scope.transactionMerchant,
      amount: $scope.transactionAmount,
      category: $scope.transactionCategory
    });

    $state.go('toadd');

  };

    $scope.transactionAmount = "";
    $scope.transactionDate =  "";
    $scope.transactionMerchant= "";
    $scope.transactionCategory= "";



})

// End of Transaction Controller


// Start of Account Controller


.controller('AccountCtrl', function($scope) {
})

// End of Account Controller


// Start of Login Controller


.controller('LoginCtrl', function($scope, $location, UserSession, $ionicLoading, $ionicPopup, $state) {
    $scope.loadingMessage = null;

    $scope.goSignup = function()
    {
      $state.go('signup');
    };

    $scope.login = function(email, password) {
      $scope.loadingMessage = "Logging in";
      var user_session = new UserSession({ user: { email: email, password: password, token: window.localStorage['token'] || "" }});
      user_session.$save(
        function(data){
          $scope.loadingMessage = null;
          window.localStorage['email'] = email;
          window.localStorage['password'] = password;
          $state.go('dashboard');
        },
        function(err){
          $scope.loadingMessage = null;
          $ionicPopup.alert({
            title: 'An error occured',
            template: err["data"]["error"]
          });
        }
      );
    };

    $scope.$watch("loadingMessage", function(newValue) {
      if (newValue) {
        $ionicLoading.show({template: '<p class="item-icon-left">' + newValue + '...<ion-spinner icon="lines"/></p>'});
      } else {
        $ionicLoading.hide();
      }
    });

    if (window.localStorage['email'] && window.localStorage['password'])
    {
      $scope.login(window.localStorage['email'], window.localStorage['password']);
    }
})


// End of Login Controller


// Start of SignUp Controller

.controller('SignupCtrl', function($scope, $location, SignupSession, $ionicPopup, $state) {
    $scope.goLogin = function()
    {
      $state.go('login');
    };

    $scope.signup = function(email, password, repeat_password) {
      if (password != repeat_password)
      {
        $ionicPopup.alert({
          title: 'Error',
          template: 'Password doesn\'t match'
        });

        return;
      }

      var user_session = new SignupSession({ user: { email: email, password: password }});
      user_session.$save(
        function(data){
          window.localStorage['email'] = email;
          window.localStorage['password'] = password;
          $location.path('/dashboard');
        },
        function(err){
          $ionicPopup.alert({
            title: 'An error occured',
            template: err["data"]["error"]
          });
        }
      );
    }
})

// End of SignUp Controller

;
