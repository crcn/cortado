class RemoteClient extends require("events").EventEmitter

  ###
  ###

  constructor: () ->
    @_socket = new SockJS("/sock")
    @_socket.onmessage = @_onMessage


  ###
  ###

  _onMessage: (event) =>
    d = JSON.parse(event.data)
    @emit d.event, d.data

module.exports = RemoteClient
