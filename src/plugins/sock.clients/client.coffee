class Client extends require("events").EventEmitter
  
  ###
  ###

  constructor: (@_con) ->
    @_con.on "data", @_onMessage

  ###
  ###

  send: (data) ->
    @_con.write JSON.stringify data

  ###
  ###
  
  _onMessage: (event) =>
    return unless event
    d = JSON.parse(event)
    @emit d.event, d.data
    @emit "event", d

module.exports = Client