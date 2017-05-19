
angular.module('starter', ['ionic', 'ngRoute']) //, Add 'starter.services'??

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);

    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
})

.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

    .state('app', {
    url: '/app',
    abstract: true,
    templateUrl: 'templates/menu.html',
    controller: 'AppCtrl'
  })

  .state('app.budget', {
    url: '/budget',
    views: {
      'menuContent': {
        templateUrl: 'templates/budget.html',
        controller: 'BudgetCtrl'
      }
    }
  })

  .state('app.budget-edit', {
      url: '/budget-edit',
      views: {
        'menuContent': {
          templateUrl: 'templates/budget-edit.html'
        }
      }
  })

  .state('app.category', {
      url: '/category/:categoryId',
      views: {
        'menuContent': {
          templateUrl: 'templates/category.html',
          controller: 'CategoriesCtrl'
        }
      }
  })


  .state('app.accounts', {
    url: '/accounts',
    views: {
      'menuContent': {
          templateUrl: 'templates/accounts.html',
          controller: 'AccountCtrl'
      }
    }

  })

    .state('app.transactions', {
      url: '/transactions',
      views: {
       'menuContent': {
          templateUrl: 'templates/transactions.html',
         controller: 'TransactionsCtrl'

        }
      }
    })

    .state('app.transactions-add', {
      url: '/transactions-add',
      views: {
        'menuContent': {
          templateUrl: 'templates/transactions-add.html',
          controller: 'TransactionsCtrl'
        }
      }
    })

    .state('app.login2', {
      url: '/login2',
      views: {
        'menuContent': {
          templateUrl: 'templates/login2.html',
          Controller: 'LoginCtrl'
        }
      }
    })

    .state('app.signup', {
      url: '/signup',
      views: {
        'menuContent': {
          templateUrl: 'templates/signup.html',
          controller: 'SignupCtrl'
        }
      }
    })

  ;

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/app/budget');
});
