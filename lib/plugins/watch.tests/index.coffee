exports.require = ["sock.clients", "config"]
exports.plugin = (clients, config) ->
  
  keepAlive = config.get("keepAlive")

  numRunning = 0
  hasErrors = 0
  clients.on "client", (client) ->
    client.on "startTests", () ->
      numRunning++
      console.log "start"

    client.on "endTests", (info) ->
      hasErrors = hasErrors or info.failureCount?
      unless --numRunning

      console.log "end"
