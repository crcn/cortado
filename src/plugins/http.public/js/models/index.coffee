bindable = require "bindable"

models = require("mojojs").models
models.set {
  logs: logs = new bindable.Collection([], "label")
  failureCount: 0,
  successCount: 0,
  testDuration: "0 s"
}

_logId = 0
models.addLog = (log) -> 
  log._id = _logId++
  logs.push nl = new bindable.Object log
  nl


module.exports = models