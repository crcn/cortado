exports.require = ["sock.clients", "tests", "pubsub"]
exports.plugin = (clients, tests, pubsub) ->
  
  # define the controls
  controls = 
    reload: () -> 
      clients.send { event: "reload" }

  platform = (event) ->
    return "Browser" unless event.client.platform
    p = event.client.platform
    "#{p.name}@#{p.version.split('.').shift()}"


  clients.on "fail", (event) ->
    p = platform event
    pubsub.publish "error", { message: "#{p} - #{event.data.message}"}

  clients.on "startTests", (event) ->
    p = platform event
    pubsub.publish "notify", { type: "info", message: "#{p} - tests start"}

  clients.on "endTests", (event) ->
    p = platform event
    pubsub.publish "notify", { type: "info", message: "#{p} - tests complete"}

  tests.on "bundle", controls.reload


  controls

