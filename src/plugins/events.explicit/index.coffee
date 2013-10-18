exports.require = ["config", "pubsub"]
exports.load = (config, pubsub) ->
  events = config.get("events") ? {}

  for name of events
    pubsub.subscribe name, events[name]
