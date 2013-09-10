spawn = require("child_process").spawn
request = require "request"

exports.require = ["config", "pubsub"]
exports.plugin = (config, pubsub) ->
  port = 18493

  startNotifier = () ->
    proc = spawn(__dirname + "/../../../node_modules/.bin/node-osx-notifier", [port])
    proc.on "exit", () ->
      setTimeout startNotifier, 1000 * 5

  startNotifier()

  notifier = 
    notify: (data) ->
      path = if data.success then "success" else "fail"
      req = request.get("http://localhost:#{port}/#{path}?message=#{encodeURIComponent(String(data.message))}&title=Cortado")
      req.on "error", () ->


  pubsub.subscribe "error", (err) ->
    notifier.notify { success: false, message: err.message }

  pubsub.subscribe "success", (data) ->
    notifier.notify { success: true, message: data.message }

  notifier
