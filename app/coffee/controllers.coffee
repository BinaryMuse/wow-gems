window.IndexController = (scope, gems, GemFilter) ->
  scope.loaded = false

  saveFilter = (filter) ->
    localStorage?.setItem('savedFilter', JSON.stringify(filter))

  loadFilter = ->
    JSON.parse(localStorage?.getItem('savedFilter')) ? {}

  gems.get().success (data, status, headers, config) ->
    storedFilter = loadFilter()
    scope.filter = new GemFilter(data.gems, storedFilter)
    scope.loaded = true

  scope.gemUrl = (id) ->
    "http://www.wowhead.com/item=#{id}"

  scope.reset = ->
    scope.filter.reset()
    saveFilter(scope.filter.filter)

  scope.refilter = ->
    scope.filter.refilter()
    saveFilter(scope.filter.filter)

  scope.canFilter = (category, type) ->
    scope.filter.canFilter(category, type)

window.IndexController.$inject = ['$scope', 'gems', 'GemFilter'];
