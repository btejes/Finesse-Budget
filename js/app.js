// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.controllers' is found in controllers.js
angular.module('starter', ['ionic', 'starter.controllers','firebase']) //, Add 'starter.services'??

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

    .state('app.budget.category', {
      url: '/category', // Change that so we can have #/app/budget/category
      views: {
        'menuContent': {
          templateUrl: 'templates/category.html',
          controller: 'BudgetCtrl'
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

    .state('app.transactions-add', {
      url: '/transactions-add',
      views: {
        'menuContent': {
          templateUrl: 'templates/transactions-add.html',
          controller: 'TransactionsCtrl'
        }
      }
    })

    .state('app.category-add', {
      url: '/category-add',
      views: {
        'menuContent': {
          templateUrl: 'templates/category-add.html'
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

  ;

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/app/budget');
});
