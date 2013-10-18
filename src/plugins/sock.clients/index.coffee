Clients = require "./clients"

exports.require = ["sock.server"]
exports.load = (sockServer) ->
  new Clients sockServer
