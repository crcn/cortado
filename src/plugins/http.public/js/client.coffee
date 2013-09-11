class RemoteClient extends require("events").EventEmitter

  ###
  ###

  constructor: () ->
    @_socket = new SockJS("/sock")
    @_socket.onmessage = @_onMessage
    @_socket.onopen = @_onOpen
    @once "ready", () =>
      @_ready = true

  ###
  ###

  ready: (cb) ->
    return cb() if @_ready
    called = false
    @once "ready", () ->
      return if called
      called = true
      cb()

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
    @emit "open", { platform: platform }
    @send { event: "open", data: { platform: platform } }

module.exports = RemoteClient
