class Tester
  
  ###
  ###

  constructor: (@_launcher, @browser, @clients) ->
    [@browserName, @browserVersion] = @browser.split("@")

  ###
  ###

  run: (next) ->
    @_launcher.start @browser, "http://student.classdojo.dev:8083/test", (err) =>
      return next(err) if err?


    @clients.on "open", (data) =>
      p      = data.platform
      verson = p.version.split(".").shift()
      name   = p.name.toLowerCase()
      client = p.client

      client.



module.exports = Tester