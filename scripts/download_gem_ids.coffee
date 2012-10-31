#!/usr/bin/env ./node_modules/.bin/coffee
fs = require 'fs'
request = require 'request'
mopGemUrl = 'http://www.wowhead.com/items=3?filter=cr=166;crs=5;crv=0'
idRegex = /_\[([^\]]+)\]=/g

unless fs.existsSync(__dirname + "/../app/data/api")
  console.error '[ERROR] app/data/api directory does not exist'
  process.exit(1)

updateJson = (id) ->
  cacheFile = __dirname + "/../app/data/api/#{id}.json"
  if fs.existsSync cacheFile
    console.log " [INFO] Data cached for item #{id}, skipping..."
    return

  itemUrl = "http://us.battle.net/api/wow/item/#{id}"
  request itemUrl, (err, resp, body) ->
    if err?
      console.error "[ERROR] Error #{err} for item #{id}"
    else
      fs.writeFileSync cacheFile, body, 'utf8'

request mopGemUrl, (err, resp, body) ->
  gemIds = []
  while result = idRegex.exec(body)
    gemIds.push result[1] unless result[1] == '76714' # http://www.wowhead.com/item=76714

  for id in gemIds
    updateJson(id)
