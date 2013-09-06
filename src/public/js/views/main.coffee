class MainView extends require("mojojs").View
  paper: require("./main.pc")

  sections:
    preview: 
      type: require("./preview")
    details:
      type: require("./details")

module.exports = MainView