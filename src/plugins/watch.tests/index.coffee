gaze = require "gaze"

exports.require = ["tests", "config"]
exports.plugin = (tests, config) ->
  return unless config.get("keepAlive")
  gaze tests.search, () ->
    this.on "all", tests.bundle

