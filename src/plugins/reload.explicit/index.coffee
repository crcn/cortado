exports.require = ["config", "tests"]
exports.load = (config, tests) ->
  return unless fn = config.get("reload")
  tests.on "bundle", fn



