express    = require "express"
httpProxy  = require "http-proxy"
Url        = require "url"
browserify = require "browserify-middleware"
glob       = require "glob"


startServer = (options) ->
  proxy  = new httpProxy.RoutingProxy()
  server = express()
  port   = options.port or 8083

  console.log "listening on port %d", port

  urlInfo = Url.parse options.proxy

  server.use "/test", express.static __dirname + "/public"
  server.use "/test/js/app.bundle.js", browserify(__dirname + "/public/js/index.js")

  scripts = []
  for script in options.scripts
    scripts = glob.sync(script).concat(scripts)

  server.use "/test/js/scripts.bundle.js", browserify(scripts)

  # needed for cross-domain policy
  server.all "/**", (req, res) ->
    proxy.proxyRequest(req, res, {
      host: urlInfo.hostname,
      port: urlInfo.port
    })

  server.listen port

exports.start = (config) ->
  startServer config