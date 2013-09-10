class Client extends require("events").EventEmitter
  
  ###
  ###

  constructor: (@_con, @_clients) ->
    @_con.on "data", @_onMessage
    @on "open", @_onOpen

  ###
  ###

  send: (data) ->
    @_con.write JSON.stringify data

  ###
  ###

  _onOpen: (data) =>
    @platform = data.platform

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