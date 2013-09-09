class RemoteClient extends require("events").EventEmitter

  ###
  ###

  constructor: () ->
    @_socket = new SockJS("/sock")
    @_socket.onmessage = @_onMessage
    @_socket.onopen = @_onOpen

  ###
  ###

  ready: (cb) ->
    return cb() if @_ready
    @once "open", cb

  ###
  ###

  send: (data) =>
    @_socket.send JSON.stringify data

  ###
  ###

  _onMessage: (event) =>
    d = JSON.parse(event.data)
    @emit d.event, d.data

  ###
  ###

  _onOpen: () =>
    @_ready = true
    @emit "open"

module.exports = RemoteClient
