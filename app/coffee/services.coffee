services = angular.module 'gem-finder.services', []
services.value('version', '0.1')
services.factory('gems', ['$http', ($http) ->
  ->
    $http(method: 'GET', url: '/data/gems.json')
])
