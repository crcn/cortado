class LogView extends require("mojojs").View
  bindings:
    "model.success, model.pending":
      "checkColor": 
        "map": (success, pending) ->
          if pending
            return "blue"
          if success
            return "green"
          return "red"
      "checkText": 
        "map": (success, pending) ->
          if pending
            return "."
          if success
            return "&#x2714;"
          return "&#x2718;"


  paper: require("./index.pc")
  
module.exports = LogView