exports.require = ["sock.clients", "tests", "pubsub"]
exports.plugin = (clients, tests, pubsub) ->
  
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
      pubsub.publish "notify", { type: "info", message: "#{browser} - tests start"}
      console.log "%s    starting tests", browser

    client.on "test", (data) =>
      inf = "#{browser} - #{data.description}"
      if data.error
        console.error("%s %s %s", browser, "✘".red, data.description)
        pubsub.publish "error", new Error inf
        console.error("%s   ", browser, data.error.message)
      else
        console.log("%s %s %s", browser, "✔".green, data.description)
        @emit "success", { message: inf }

    client.on "endTests", (result) ->
      inf = "#{browser} - success: #{result.successCount}, errors: #{result.failureCount}, duration: #{result.duration} s"
      console.log "%s    %s", browser, "completed tests, success: #{result.successCount}, errors: #{result.failureCount}, duration: #{result.duration} s"
      pubsub.publish "notify", { type: "info", message: inf }
      pubsub.publish "completeTests"

  tests.on "bundle", controls.reload


  controls

