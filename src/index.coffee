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

saveBundledScripts = (clients, options) ->
  scripts = []
  for script in options.scripts
    scripts = glob.sync(script).concat(scripts)

  buffer = []
  for script in scripts
    buffer.push "require('#{ script }');"

  # should be unique incase we have other cortado scripts running
  hash = crypto.createHash('md5').update(options.cwd).digest("hex")

  tmpScript = "/tmp/#{hash}.js"
  fs.writeFileSync tmpScript, buffer.join("\n;")


  console.log "waiting for tests..."

  clients.send { event: "reload" }

  tmpScript

###
###

watchScripts = (options, callback) ->
  gaze options.scripts, () ->
    this.on "all", callback


###
###

watchTests = (clients) ->
  clients.on "test", (data) ->
    if data.error
      console.error("✘", data.description)
      console.error("  ", data.error.message)
    else
      console.log("✔", data.description)

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
  watchTests clients

  # needed for cross-domain policy
  app.all "/**", (req, res) ->
    proxy.proxyRequest(req, res, {
      host: urlInfo.hostname,
      port: urlInfo.port
    })

  server.listen port

exports.start = (config) ->
  startServer config