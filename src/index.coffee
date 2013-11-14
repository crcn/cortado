packages = require "packages"
bindable = require "bindable"

require "colors"

exports.start = (options) ->

  options.cwd = process.cwd()

  plug = packages().
  require({ config: new bindable.Object(options) }).
  require(__dirname + "/plugins").
  load()

  plug.exports.mediator.on "pre reload", "load"
  plug.exports.mediator.execute "load", (err) ->

    if err
      console.error err.stack
      return process.exit(1)
    plug.exports.mediator.execute "open"
