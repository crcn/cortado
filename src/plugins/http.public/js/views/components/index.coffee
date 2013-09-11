paperclip = require "paperclip"


nc = {
  iframe: require("./iframe")
}

components = require("mojojs").models.get("components")
components.set nc

paperclip.use require("paperclip-component")(components)