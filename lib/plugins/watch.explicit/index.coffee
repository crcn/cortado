gaze = require "gaze"
exports.require = ["config", "sock.clients.controls", "config"]
exports.plugin = (config, controls, config) ->
  watch = config.get("watch")
  return if not watch or not config.get("keepAlive")
  console.log "watching %s", watch
  gaze watch, controls.reload