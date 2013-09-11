
class LogrollView extends require("mojojs").View
  paper: require("./index.pc")
  sections:
    logs:
      type: "list"
      source: "models.logs"
      modelViewClass: require("./log")

module.exports = LogrollView