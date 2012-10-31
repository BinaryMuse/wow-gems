#!/usr/bin/env ./node_modules/.bin/coffee
fs = require 'fs'

gems =
  gems: []

typeMap =
  RED: 'Red'
  BLUE: 'Blue'
  YELLOW: 'Yellow'
  GREEN: 'Green'
  PURPLE: 'Purple'
  ORANGE: 'Orange'
  COGWHEEL: 'Cogwheel'
  HYDRAULIC: 'Sha-Touched'
  META: 'Meta'

socketMap =
  RED: 'Red'
  BLUE: 'Blue'
  YELLOW: 'Yellow'
  GREEN: 'Blue,Yellow'
  PURPLE: 'Red,Blue'
  ORANGE: 'Red,Yellow'
  COGWHEEL: 'Cogwheel'
  HYDRAULIC: 'Sha-Touched'
  META: 'Meta'

qualityMap =
  0: 'Junk'
  1: 'Common'
  2: 'Uncommon'
  3: 'Rare'
  4: 'Epic'
  5: 'Legendary'

parseStats = (description) ->
  parts = description.split(' and ')
  prefixRegexPlus = /^(\+\S+) (.*)$/
  prefixRegexPercent = /^(\S+\%) (.*)$/
  suffixRegex = /^(.*) by (\S+)$/

  stats = []
  for part in parts
    if match = prefixRegexPlus.exec(part)
      stats.push { stat: match[2], amount: match[1] }
    if match = prefixRegexPercent.exec(part)
      stats.push { stat: match[2], amount: match[1] }
    else if match = suffixRegex.exec(part)
      stats.push { stat: match[1], amount: match[2] }
  stats

jsonDir = __dirname + "/../app/data/api"
files = fs.readdirSync jsonDir
for file in files
  data = fs.readFileSync "#{jsonDir}/#{file}", 'utf8'
  data = JSON.parse data
  if data.gemInfo?
    type = typeMap[data.gemInfo.type.type]
    unless type?
      console.error "[ERROR] No type map for #{data.gemInfo.type.type}"
      process.exit(1)
    gem =
      id: data.id
      name: data.name
      type: type
      jcOnly: data.requiredSkill != 0
      quality: qualityMap[data.quality]
      sockets: socketMap[data.gemInfo.type.type].split(',')
      stats: parseStats(data.gemInfo.bonus.name)
    gems.gems.push(gem)

fs.writeFileSync __dirname + "/../app/data/gems.json", JSON.stringify(gems), 'utf8'
