class IFrame extends require("mojojs").View

  ###
  ###

  constructor: () ->

  ###
  ###

  _onRender: () ->
    super()
    iframe = document.createElement "iframe"
    iframe.onload = @get("onload")

    @bind("src").to((src) -> 
      iframe.src = src
    ).now()

    @section.append iframe




module.exports = IFrame