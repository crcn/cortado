eyebrowse = require "eyebrowse"

exports.require = ["config"]
exports.plugin = (config) ->
  return unless config.get("eyebrowse")
  client = new eyebrowse.Client config.get("eyebrowse")
  start: (name, url, callback) ->
    info = name.split("@")
    client.start { 
      name: info.shift(), 
      version: info.shift(),
      args: [url],
    }, callback