crypto     = require "crypto"
glob       = require "glob"
fs         = require "fs"
events     = require "events"




class Tests extends events.EventEmitter

  ###
  ###

  constructor: (@config) ->
    @search = @config.get("scripts")

  ###
  ###

  bundle: () => 
    scripts = []
    for script in @search
      scripts = glob.sync(script).concat(scripts)

    buffer = []
    for script in scripts
      buffer.push "require('#{ script }');"

    # should be unique incase we have other cortado scripts running
    hash = crypto.createHash('md5').update(@config.get("cwd")).digest("hex")

    tmpScript = "/tmp/#{hash}.js"
    fs.writeFileSync tmpScript, buffer.join("\n;")

    @emit "bundle", { path: tmpScript }


    tmpScript



exports.require = ["config", "mediator"]
exports.load = (config, mediator) -> 
  tests = new Tests config
  tests.on "bundle", () -> mediator.execute "reload"

