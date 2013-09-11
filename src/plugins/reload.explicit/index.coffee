exports.require = ["config", "tests"]
exports.plugin = (config, tests) ->
  return unless fn = config.get("reload")
  tests.on "bundle", fn



