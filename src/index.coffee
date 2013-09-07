express    = require "express"
httpProxy  = require "http-proxy"
Url        = require "url"
browserify = require "browserify-middleware"
glob       = require "glob"
fs         = require "fs"
crypto     = require "crypto"

cacher = (options) ->
  
  # don't cache anything if full integration test
  unless options.full
    return (req, res, next) -> next()

  cache = options.cache
  types = cache.types
  dir   = cache.directory
  
  # otherwise, cache everything
  (req, res, next) ->


getIncScript = (options) ->

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

  tmpScript




###
###

startServer = (options) ->
  options.cwd = process.cwd()
  proxy  = new httpProxy.RoutingProxy()
  server = express()
  port   = options.port or 8083

  console.log "listening on port %d", port

  urlInfo = Url.parse options.proxy

  server.use cacher options
  server.use "/test", express.static __dirname + "/public"
  server.use "/test/js/app.bundle.js", browserify(__dirname + "/public/js/index.js")
  server.use "/test/js/scripts.bundle.js", browserify(getIncScript(options))

  # needed for cross-domain policy
  server.all "/**", (req, res) ->
    proxy.proxyRequest(req, res, {
      host: urlInfo.hostname,
      port: urlInfo.port
    })

  server.listen port

exports.start = (config) ->
  startServer config