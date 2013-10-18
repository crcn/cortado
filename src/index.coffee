packages = require "packages"
bindable = require "bindable"

require "colors"

exports.start = (options) ->

  options.cwd = process.cwd()

  plug = packages().
  require({ config: new bindable.Object(options) }).
  require(__dirname + "/plugins").
  load()

  plug.exports.pubsub.publish "init"
