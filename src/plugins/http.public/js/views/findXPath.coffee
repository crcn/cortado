findXPath = require "../utils/findXPath"

class FindBestXPathView extends require("mojojs").View

  ###
  ###

  define: ["findXPath"]
  
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
    @_cleanup()

    return unless @get("findXPath")

    @_docBinding = @bind("doc").to((@_cdoc) =>
      @_cleanupListeners()
      for event in @events
        @_cdoc?.addEventListener event, @_onClickElement, true
    ).now()

  ###
  ###

  _cleanup: () =>
    @_docBinding?.dispose()
    @_cleanupListeners()



  ###
  ###

  _cleanupListeners: () =>
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
