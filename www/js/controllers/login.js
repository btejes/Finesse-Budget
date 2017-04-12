angular.module('starter')

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
  });

