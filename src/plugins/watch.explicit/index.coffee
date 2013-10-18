gaze = require "gaze"
exports.require = ["config", "tests"]
exports.load = (config, tests) ->
  watch = config.get("watch")
  return if not watch or not config.get("keepAlive")
  console.log "watching %s", watch.join "\n"
  gaze watch, () ->
    this.on "all", tests.bundle

  