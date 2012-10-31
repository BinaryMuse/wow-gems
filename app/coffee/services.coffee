class GemFilter
  constructor: (@allGems) ->
    @gems = @allGems.sort (a, b) ->
      if a.type > b.type then 1 else -1

    @filter =
      types:
        Red: false
        Blue: false
        Yellow: false
        Purple: false
        Green: false
        Orange: false
        Meta: false
        Cogwheel: false
        'Sha-Touched': false
      sockets: {}
      qualities:
        Uncommon: false
        Rare: false
        Epic: false
        Legendary: false
      stats: {}
      jewelcrafting:
        'Requires Jewelcrafting': false
        'Usable by Non-Jewelcrafters': false

    @filterValues =
      types: Object.keys(@filter.types)
      stats: []
      sockets: []
      qualities: Object.keys(@filter.qualities)
      jewelcrafting: Object.keys(@filter.jewelcrafting)

    types = []
    stats = []
    sockets = []
    qualities = []
    for gem in @gems
      types.push(gem.type) unless gem.type in types
      qualities.push(gem.quality) unless gem.quality in qualities
      for stat in gem.stats
        stats.push stat.stat unless stat.stat in stats
      for socket in gem.sockets
        sockets.push socket unless socket in sockets

    @filter.stats[stat] = false for stat in stats
    @filter.sockets[socket] = false for socket in sockets
    @filterValues.stats = (stat for stat in stats)
    @filterValues.sockets = (socket for socket in sockets)

    @categories = Object.keys(@filter)

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
    else if category == 'sockets'
      newGems = (gem for gem in gems when type in gem.sockets)
    else if category == 'qualities'
      newGems = (gem for gem in gems when type == gem.quality)
    else if category == 'jewelcrafting'
      newGems = (gem for gem in gems when gem.jcOnly == true) if type == 'Requires Jewelcrafting'
      newGems = (gem for gem in gems when gem.jcOnly == false) if type == 'Usable by Non-Jewelcrafters'
    newGems

  # Called on every tick or untick of a checkbox in the filter.
  # Starts from all gems and applies every enabled filter.
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
