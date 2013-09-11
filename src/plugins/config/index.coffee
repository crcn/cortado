bindable = require "bindable"

exports.plugin = (plugin) ->
  p = plugin.params()
  p.cwd = process.cwd()
  new bindable.Object p