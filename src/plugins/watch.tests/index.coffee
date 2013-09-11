###
  waits for browsers, then kills cortado
  after all browsers have completed
###

exports.require = ["sock.clients", "config"]
exports.plugin = (clients, config) ->
  
  keepAlive = config.get("keepAlive")


  numRunning = 0
  hasErrors = 0

  killProcess = () -> 
    setTimeout (() ->
      process.exit Number hasErrors
    ), 100


  clients.on "client", (client) ->
    client.on "startTests", () ->
      numRunning++

    client.on "endTests", (info) ->
      hasErrors = hasErrors or info.failureCount > 0

      if not --numRunning and not keepAlive
        killProcess()

