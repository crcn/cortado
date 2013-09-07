MainView = require "./views/main"
models   = require "./models"
commands = require "./commands"

window.actions = actions = require("./actions")(models)
window.xpath   = require("xpgen")()
window.expect  = require("expect.js")



$(document).ready () -> 
  main = new MainView()
  main.attach $ "#application"


mocha.setup({ 
  reporter: require("./reporters/mocha")(models)
  ui: "bdd",
  timeout: 1000 * 9999
})


describe "abba", () ->
  it "can login", (next) ->
    actions.
    visit("/logout").
    visit("/").
    type(xpath.find().eq("@id", "application").find().eq("@placeholder", "Username"), "liamdon").
    type(xpath.find().eq("@id", "application").find().eq("@placeholder", "Password"), "password").
    click(xpath.find().eq("@id", "login-button")).
    then(next)

  it "fails", (next) ->
    actions.
    click(xpath.find().eq("@id", "fsdfsd")).
    then(next)



mocha.run()
