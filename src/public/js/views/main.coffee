class MainView extends require("mojojs").View
  paper: require("./main.pc")

  successCount: 24
  failureCount: 0
  duration: "4:30 s"

  sections:
    preview: 
      type: require("./preview")
    logroll:
      type: require("./logroll")

module.exports = MainView