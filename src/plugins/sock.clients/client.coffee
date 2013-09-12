class Client extends require("events").EventEmitter
  
  ###
  ###

  constructor: (@_con, @_clients) ->
    @_con.on "data", @_onMessage
    @on "open", @_onOpen
    @_con.on "close", @_onClose
    @name = "Browser"

  ###
  ###

  send: (data) ->
    @_con.write JSON.stringify data

  ###
  ###

  _onOpen: (data) =>
    @platform = data.platform
    @name = @platform.name + "@" + @platform.version.split(".").shift()
    @send  { event: "ready" }

  ###
  ###

  _onClose: () =>
    @emit "close"


  ###
  ###

  toString: () ->
    @name

  ###
  ###
  
  _onMessage: (event) =>
    return unless event
    d = JSON.parse(event)
    d.client = @
    @emit d.event, d.data
    @emit "event", d
    @_clients.emit d.event, d


module.exports = Client