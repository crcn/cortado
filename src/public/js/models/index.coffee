bindable = require "bindable"

models = require("mojojs").models
models.set "logs", logs = new bindable.Collection([], "label")

_logId = 0
models.addLog = (log) -> 
  log._id = _logId++
  logs.push nl = new bindable.Object log
  nl


module.exports = models