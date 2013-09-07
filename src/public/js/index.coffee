MainView = require "./views/main"
models   = require "./models"
commands = require "./commands"
RemoteClient = require "./client"

window.actions = actions = require("./actions")(models)
window.xpath   = require("xpgen")()
window.expect  = require("expect.js")

client = new RemoteClient()

client.on "reload", () -> 
  window.location.reload()

$(document).ready () -> 
  main = new MainView()
  main.attach $ "#application"


mocha.setup({ 
  reporter: require("./reporters/mocha")(models)
  ui: "bdd",
  timeout: 1000 * 9999
})



