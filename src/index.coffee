plugin = require "plugin"
require "colors"

exports.start = (options) ->
  plug = plugin().
  params(options).
  require(__dirname + "/plugins")

  plug.load (err) ->
    if err 
      console.error err.stack

    plug.exports.pubsub.publish "init"
