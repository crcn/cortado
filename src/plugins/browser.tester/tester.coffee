class Tester
  
  ###
  ###

  constructor: (@_launcher, @browser, @clients) ->
    [@browserName, @browserVersion] = @browser.split("@")

  ###
  ###

  run: (next) ->
    console.log "opening %s", @browser
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
          if data.error
            console.error("(%s) ✘", @browser, data.description)
            console.error("(%s)  ", @browser, data.error.message)
          else
            console.log("(%s) ✔", @browser, data.description)

        client.once "endTests", (result) =>
          console.log "(%s) success: %d, errors: %d, duration: %s ", @browser, result.successCount, result.failureCount, result.duration + " s"
          next()





module.exports = Tester