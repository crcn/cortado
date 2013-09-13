findXPath = require "../utils/findXPath"

class FindBestXPathView extends require("mojojs").View
  
  ###
  ###

  paper: require("./findXPath.pc")
  
  ###
  ###

  bindings:
    "models.control.document": "doc"

  ###
  ###

  events: ["mouseup", "mousedown", "click"]

  ###
  ###

  toggleFindXPath: () ->
    @set "findXPath", not @get("findXPath")
    @set "bestXPath", undefined
    @_cleanupListeners()

    return unless @get("findXPath")

    @_docBinding = @bind("doc").to((@_cdoc) =>
      @_cleanupListeners()
      for event in @events
        @_cdoc?.addEventListener event, @_onClickElement, true
    ).now()


  ###
  ###

  _cleanupListeners: () =>
    @_docBinding?.dispose()
    for event in @events
      @_cdoc?.removeEventListener event, @_onClickElement, true



  ###
  ###

  _onClickElement: (event) =>
    event.preventDefault()
    event.stopImmediatePropagation()
    try 
      @set "bestXPath", String findXPath event.target
    catch e
      @set "bestXPath", String e.message


module.exports = FindBestXPathView
