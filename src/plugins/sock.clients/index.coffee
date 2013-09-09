Clients = require "./clients"



exports.require = ["sock.server"]
exports.plugin = (sockServer) ->
  new Clients sockServer
