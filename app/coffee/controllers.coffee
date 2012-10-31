window.IndexController = (scope, gems, GemFilter) ->
  scope.loaded = false

  gems.get().success (data, status, headers, config) ->
    scope.filter = new GemFilter(data.gems)
    scope.loaded = true

window.IndexController.$inject = ['$scope', 'gems', 'GemFilter'];
