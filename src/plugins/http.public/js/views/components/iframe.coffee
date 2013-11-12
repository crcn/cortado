hurryup = require "hurryup"

class IFrame extends require("mojojs").View
  
  ###
  ###

  define: ["onLoad", "src", "class", "id"]

  ###
  ###

  _onRender: () ->
    super()
    iframe = document.createElement "iframe"


    @bind("onLoad").to((onLoad) ->
      if iframe.attachEvent
        iframe.attachEvent "onload", onLoad
      else
        iframe.onload = onLoad
    ).now()

    for attr in ["src", "class", "id"] then do (attr) =>
      @bind(attr).to((value) ->

        return if value is undefined

        if /class|id/.test attr
          iframe.setAttribute attr, value
        else
          iframe[attr.toLowerCase()] = value

      ).now()

    @section.append iframe






module.exports = IFrame