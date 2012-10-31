window.IndexController = (scope, gems, GemFilter) ->
  scope.loaded = false

  gems.get().success (data, status, headers, config) ->
    scope.filter = new GemFilter(data.gems)
    scope.loaded = true

  scope.gemUrl = (id) ->
    "http://www.wowhead.com/item=#{id}"

window.IndexController.$inject = ['$scope', 'gems', 'GemFilter'];
