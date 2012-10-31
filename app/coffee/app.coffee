# Declare app level module which depends on filters, and services
window.app = angular.module 'gem-finder', ['gem-finder.filters', 'gem-finder.services', 'gem-finder.directives']
app.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/', templateUrl: 'partials/main.htm', controller: IndexController)
  $routeProvider.otherwise(redirectTo: '/')
])
