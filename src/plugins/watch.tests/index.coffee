###
  waits for browsers, then kills cortado
  after all browsers have completed
###

exports.require = ["sock.clients", "config"]
exports.load = (clients, config) ->
  
  keepAlive = config.get("keepAlive")


  numRunning = 0
  hasErrors = 0

  killProcess = () -> 
    setTimeout (() ->
      process.exit Number hasErrors
    ), 100


  tryKilling = () ->
    if not --numRunning and not keepAlive
      killProcess()


  clients.on "client", (client) ->
    client.on "startTests", () ->
      numRunning++


    client.on "close", onClose = () ->  
      hasErrors = true
      console.error "(%s) closed unexpectedly", client
      tryKilling()

    client.on "endTests", (info) ->
      client.removeListener "close", onClose
      hasErrors = hasErrors or info.failureCount > 0
      tryKilling()

