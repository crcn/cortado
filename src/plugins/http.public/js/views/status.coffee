class StatusView extends require("mojojs").View
  paper: require("./status.pc")

  bindings:
    "models.successCount": "successCount"
    "models.failureCount": "failureCount"
    "models.testDuration": "testDuration"
  
module.exports = StatusView