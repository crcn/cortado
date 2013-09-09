plugin = require "plugin"

exports.start = (options) ->
  plugin().
  params(options).
  require(__dirname + "/plugins").
  load (err) ->
    if err 
      console.error err.stack
