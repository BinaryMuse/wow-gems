window.IndexController = (scope, gems) ->
  scope.loaded = false
  scope.allGems = []
  scope.filteredGems = []

  makeValue = (str) ->
    str.replace(/[^a-z]/ig, '').toLowerCase()

  scope.filter =
    types: {}
    stats: {}

  scope.filterValues =
    types: []
    stats: []

  gems().success (data, status, headers, config) ->
    scope.allGems = data.gems
    scope.filteredGems = data.gems
    scope.loaded = true

    types = []
    stats = []
    for gem in data.gems
      types.push(gem.type) unless gem.type in types
      for stat in gem.stats
        stats.push stat.stat unless stat.stat in stats

    scope.filter.types[makeValue(type)] = false for type in types
    scope.filter.stats[makeValue(stat)] = false for stat in stats
    scope.filterValues.types = ({name: type, value: makeValue(type)} for type in types)
    scope.filterValues.stats = ({name: stat, value: makeValue(stat)} for stat in stats)

  scope.filterCategories = ['Types', 'Stats']

  # Returns an array of gems that are both in `gems` and that should
  # continue to be shown if the filter is modified so that
  # `filter[category][value]` is set to true.
  applyScope = (gems, category, type) ->
    newGems = []
    if category == 'types'
      newGems = (gem for gem in gems when gem.type == type)
    else if category == 'stats'
      for gem in gems
        statNames = (obj.stat for obj in gem.stats)
        newGems.push gem if type in statNames
    newGems

  # Called on every tick or untick of a checkbox in the filter.
  # Starts from all gems and applies every filter until.
  scope.refilter = ->
    newGems = scope.allGems
    for category, obj of scope.filter
      for type, value of obj
        newGems = applyScope(newGems, category, type) if value == true
    scope.filteredGems = newGems

  scope.canFilter = (category, type) ->
    newGems = applyScope(scope.filteredGems, category, type)
    newGems.length != 0

  window.s = scope
  window.f = scope.filter

window.IndexController.$inject = ['$scope', 'gems'];
