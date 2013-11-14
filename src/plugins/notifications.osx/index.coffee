spawn = require("child_process").spawn
request = require "request"

exports.require = ["config", "mediator"]
exports.load = (config, mediator) ->
  port = 18493

  startNotifier = () ->
    proc = spawn(__dirname + "/../../../node_modules/.bin/node-osx-notifier", [port])
    proc.on "error", () ->
    proc.on "exit", () ->
      setTimeout startNotifier, 1000 * 5

  startNotifier()

  notifier = 
    notify: (data) ->
      path = data.type
      req = request.get("http://localhost:#{port}/#{path}?message=#{encodeURIComponent(String(data.message))}&title=Cortado")
      req.on "error", () ->


  mediator.on "notify", (data) ->
    notifier.notify data


  mediator.on "error", (err) ->
    notifier.notify { type: "fail", message: err.message }

  mediator.on "success", (data) ->
    notifier.notify { type: "pass", message: data.message }

  notifier
