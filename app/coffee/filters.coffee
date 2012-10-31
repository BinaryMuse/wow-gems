filters = angular.module 'gem-finder.filters', []

filters.filter 'capitalize', [->
  (str) ->
    str.charAt(0).toUpperCase() + str.slice(1)
]

filters.filter 'value', [->
  (str) ->
    str.replace(/[^a-z]/ig, '').toLowerCase()
]
