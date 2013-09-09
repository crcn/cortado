exports.require = ["sock.clients", "tests"]
exports.plugin = (clients, tests) ->
  tests.on "bundle", () ->
    console.log "tests changed, updating clients"
    clients.emit "reload"