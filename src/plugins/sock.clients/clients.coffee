Client = require "./client"

class Clients extends require("events").EventEmitter

  ###
  ###

  constructor: (@_sock) ->
    @_clients = []
    @_sock.on "connection", @_conConnection

  ###
  ###

  send: (data) ->
    for client in @_clients
      client.send data

  ###
  ###

  _conConnection: (con) =>
    @_clients.push client = new Client con, @
    client.on "event", @_onEvent
    @emit "client", client
    con.once "close", () =>
      i = @_clients.indexOf(client)
      if ~i
        @_clients.splice i, 1

  ###
  ###

  _onEvent: (event) => 
    @emit event.event, event



module.exports = Clients