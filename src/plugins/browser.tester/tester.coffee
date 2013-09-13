EventEmitter = require("events").EventEmitter

class Tester extends EventEmitter
  
  ###
  ###

  constructor: (@_launcher, @browser, @clients, @_ops) ->
    [@browserName, @browserVersion] = @browser.split("@")


  ###
  ###

  run: (next) ->

    @_launcher.start @browser, "http://#{@_ops.host}:#{@_ops.port}/test", (err, browser) =>
      
      return next(err) if err?


      @clients.on "open", listener = (event) =>
        p       = event.data.platform
        version = p.version.split(".").shift()
        name    = p.name.toLowerCase()
        client  = event.client

        return if name isnt @browserName or version isnt @browserVersion
        
        @clients.removeListener "open", listener

        client.once "endTests", (result) =>
          errors = result.errors?.map((err) -> err.message).join("\n")
          browser.stop() #kill the browser after completion
          next()
    @





module.exports = Tester