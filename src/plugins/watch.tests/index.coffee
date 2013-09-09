gaze = require "gaze"

exports.require = ["tests"]
exports.plugin = (tests) ->
  gaze tests.search, () ->
    this.on "all", tests.bundle

