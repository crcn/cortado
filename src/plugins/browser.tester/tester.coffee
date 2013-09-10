EventEmitter = require("events").EventEmitter

class Tester extends EventEmitter
  
  ###
  ###

  constructor: (@_launcher, @browser, @clients) ->
    [@browserName, @browserVersion] = @browser.split("@")

  ###
  ###

  run: (next) ->
    console.log "(%s) opening", @browser
    @_launcher.start @browser, "http://student.classdojo.dev:8083/test", (err, browser) =>
      
      return next(err) if err?


      @clients.on "open", listener = (event) =>
        p       = event.data.platform
        version = p.version.split(".").shift()
        name    = p.name.toLowerCase()
        client  = event.client

        return if name isnt @browserName or version isnt @browserVersion
        console.log "(%s) running tests", @browser
        @clients.removeListener "open", listener

        client.send { event: "runTests" }


        client.on "test", (data) =>
          inf = "#{@browser} - #{data.description}"
          if data.error
            console.error("(%s) ✘ %s", @browser, data.description)
            @emit "error", new Error inf
            console.error("(%s)  ", @browser, data.error.message)
          else
            console.log("(%s) ✔ %s", @browser, data.description)
            @emit "success", { message: inf }


        client.once "endTests", (result) =>
          console.log "(%s) success: %d, errors: %d, duration: %s ", @browser, result.successCount, result.failureCount, result.duration + " s"
          errors = result.errors?.map((err) -> err.message).join("\n")
          next(if errors then new Error(errors) else undefined)
    @





module.exports = Tester