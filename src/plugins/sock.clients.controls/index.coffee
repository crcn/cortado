exports.require = ["sock.clients", "tests"]
exports.plugin = (clients, tests) ->
  
  # define the controls
  controls = 
    reload: () -> clients.send { event: "reload" }


  controls

