exports.require = ["sock.clients", "tests", "mediator"]
exports.load = (clients, tests, mediator) ->
  
  # define the controls
  controls = 
    reload: () -> 
      clients.send { event: "reload" }



  clients.on "client", (client) ->

    browser = "Browser"

    client.on "open", () ->
      browser = "(#{client.platform.name}@#{client.platform.version.split('.').shift()})"

      # add some padding so browser logs are even
      while browser.length < 12
        browser += " "



    client.on "startTests", (event) ->
      mediator.execute "notify", { type: "info", message: "#{browser} - tests start"}
      console.log "%s    starting tests", browser

    client.on "test", (data) =>
      inf = "#{browser} - #{data.description}"
      if data.error
        console.error("%s %s %s", browser, "✘".red, data.description)
        mediator.execute "error", new Error inf
        console.error("%s   ", browser, String(data.error.message).red)
      else
        console.log("%s %s %s", browser, "✔".green, data.description)
        @emit "success", { message: inf }

    client.on "endTests", (result) ->
      inf = "#{browser} - success: #{result.successCount}, errors: #{result.failureCount}, duration: #{result.duration} s"
      console.log "%s    %s", browser, ("completed tests, success: #{result.successCount}, errors: #{result.failureCount}, duration: #{result.duration} s")
      mediator.execute "notify", { type: "info", message: inf }
      mediator.execute "completeTests"

  mediator.on "post reload", (msg, next) ->
    controls.reload()
    next()

  controls

