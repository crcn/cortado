exports.require = ["config", "mediator"]
exports.load = (config, mediator) ->
  events = config.get("events") ? {}

  for name of events
    console.log name
    mediator.on name, events[name]
