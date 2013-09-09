express    = require "express"
httpProxy  = require "http-proxy"
Url        = require "url"
browserify = require "browserify-middleware"
glob       = require "glob"
fs         = require "fs"
crypto     = require "crypto"
events     = require "events"
gaze       = require "gaze"
sockjs     = require "sockjs"
http       = require "http"
Clients    = require "./clients"

###
###

cacher = (options) ->
  
  # don't cache anything if full integration test
  unless options.full
    return (req, res, next) -> next()

  cache = options.cache
  types = cache.types
  dir   = cache.directory
  
  # otherwise, cache everything
  (req, res, next) ->



###
###

watchTests = (options, clients) ->

  clients.on "startTests", () ->
    console.log "starting tests"

  clients.on "test", (data) ->
    if data.error
      console.error("✘", data.description)
      console.error("  ", data.error.message)
    else
      console.log("✔", data.description)

  clients.on "endTests", (data) ->
    console.log "tests complete"
    console.log "success: %d, failure: %d, duration: %d s", data.successCount, data.failureCount, data.duration

###
###

startServer = (options) ->
  options.cwd = process.cwd()
  proxy  = new httpProxy.RoutingProxy()
  app = express()
  server = http.createServer app
  port   = options.port or 8083

  console.log "listening on port %d", port

  urlInfo = Url.parse options.proxy

  app.use cacher options
  app.use "/test", express.static __dirname + "/public"
  app.use "/test/js/app.bundle.js", browserify(__dirname + "/public/js/index.js")
    
  sock = sockjs.createServer({sockjs_url: "http://cdn.sockjs.org/sockjs-0.3.min.js", log: () -> })

  clients = new Clients(sock)
  sock.installHandlers(server, { prefix: "/sock" })
  app.use "/test/js/scripts.bundle.js", browserify(saveBundledScripts(clients, options))

  watchScripts options, () -> saveBundledScripts(clients, options)
  watchTests options, clients

  # needed for cross-domain policy
  app.all "/**", (req, res) ->
    proxy.proxyRequest(req, res, {
      host: urlInfo.hostname,
      port: urlInfo.port
    })

  server.listen port

exports.start = (config) ->
  startServer config