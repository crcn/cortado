express    = require "express"
browserify = require "browserify-middleware"

exports.require = ["express.server", "tests"]
exports.plugin = (expressServer, tests) ->
  stat = express.static __dirname
  expressServer.use "/test", (req, res, next) ->
    console.log "STATIC"
    static req, res, next
  expressServer.use "/test/js/app.bundle.js", browserify(__dirname + "/js/index.js")
  expressServer.use "/test/js/scripts.bundle.js", browserify(tests.bundle())