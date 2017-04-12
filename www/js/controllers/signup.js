angular.module('starter')

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
  });
