async = require "async"

exports.require = [["browser.launchers.*"], "config"]
exports.plugin = (launchers, ) ->
  browsers = config.get("browsers") or []
  limit    = config.get("limit") or 1