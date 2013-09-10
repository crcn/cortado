eyebrowse = require "eyebrowse"

exports.require = ["config"]
exports.plugin = (config) ->
  return unless config.get("eyebrowse")
  client = new eyebrowse.Client config.get("eyebrowse")
  client.start { name: "chrome", version: 27, args: ["http://google.com"] }, (err) ->
    console.log err


  start: (name, url) -.
    