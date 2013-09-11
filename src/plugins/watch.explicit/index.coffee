gaze = require "gaze"
exports.require = ["config", "tests"]
exports.plugin = (config, tests) ->
  watch = config.get("watch")
  return if not watch or not config.get("keepAlive")
  console.log "watching %s", watch
  gaze watch, () ->
    this.on "all", tests.bundle

  