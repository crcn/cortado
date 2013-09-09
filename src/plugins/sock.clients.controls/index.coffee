exports.require = ["sock.clients", "tests"]
exports.plugin = (clients, tests) ->
  
  # define the controls
  controls = 
    reload: () -> clients.emit "reload"


  # add some default hooks
  tests.on "bundle", controls.reload

  controls

