
class Preview extends require("mojojs").View
  
  ###
  ###

  paper: require("./index.pc")
  
  ###
  ###

  bindings: 
    "models.control.location": "location"
    "location": (v) ->
      @set "models.control.document", undefined
  ###
  ###

  _onIFrameLoad: () =>
    doc = @$("iframe").contents()[0]
    return if doc is document
    @set "models.control.document", doc

module.exports = Preview