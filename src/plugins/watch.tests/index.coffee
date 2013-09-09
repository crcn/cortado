gaze = require "gaze"

exports.require = ["tests"]
exports.plugin = (tests) ->
  console.log tests.search
  gaze tests.search, () ->
    this.on "all", tests.bundle

