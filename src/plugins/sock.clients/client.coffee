class Client extends require("events").EventEmitter
  
  ###
  ###

  constructor: (@_con) ->
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
    @emit d.event, d.data
    @emit "event", d

module.exports = Client