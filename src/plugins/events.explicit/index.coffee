exports.require = ["config", "pubsub"]
exports.plugin = (config, pubsub) ->
  events = config.get("events") ? {}

  for name of events
    pubsub.subscribe name, events[name]
