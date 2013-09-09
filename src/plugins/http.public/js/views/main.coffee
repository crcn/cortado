class MainView extends require("mojojs").View

  paper: require("./main.pc")
  
  sections:
    preview: 
      type: require("./preview")
    logroll:
      type: require("./logroll")
    status:
      type: require("./status")

module.exports = MainView