class GemFilter
  constructor: (@allGems) ->
    @gems = @allGems
    @filter =
      types: {}
      stats: {}
    @filterValues =
      types: []
      stats: []

    types = []
    stats = []
    for gem in @gems
      types.push(gem.type) unless gem.type in types
      for stat in gem.stats
        stats.push stat.stat unless stat.stat in stats

    @filter.types[type] = false for type in types
    @filter.stats[stat] = false for stat in stats
    @filterValues.types = (type for type in types)
    @filterValues.stats = (stat for stat in stats)

    @categories = ['types', 'stats']

  # Returns an array of gems that are both in `gems` and that should
  # continue to be shown if the filter is modified so that
  # `filter[category][value]` is set to true.
  applyScope: (gems, category, type) ->
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
  refilter: =>
    newGems = @allGems
    for category, obj of @filter
      for type, value of obj
        newGems = @applyScope(newGems, category, type) if value == true
    @gems = newGems

  canFilter: (category, type) =>
    newGems = @applyScope(@gems, category, type)
    newGems.length != 0

services = angular.module 'gem-finder.services', []

services.factory('gems', ['$http', ($http) ->
  {'get': -> $http(method: 'GET', url: '/data/gems.json')}
])

services.factory('GemFilter', [->
  GemFilter
])
