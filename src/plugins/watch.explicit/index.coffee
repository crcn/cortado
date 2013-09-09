gaze = require "gaze"
exports.require = ["config", "sock.clients.controls"]
exports.plugin = (config, controls) ->
  watch = config.get("watch")
  return unless watch
  console.log "watching %s", watch
  gaze watch, controls.reload