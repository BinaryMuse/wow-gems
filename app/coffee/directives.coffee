directives = angular.module 'gem-finder.directives', []
directives.directive 'appVersion', ['version', (version) ->
  return (scope, elm, attrs) ->
    elm.text(version)
]
