filters = angular.module 'gem-finder.filters', []
filters.filter 'interpolate', ['version', (version) ->
  (text) ->
    String(text).replace(/\%VERSION\%/mg, version)
]
