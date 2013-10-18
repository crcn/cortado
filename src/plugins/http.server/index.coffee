http = require "http"

exports.require = ["express.server", "config"]
exports.load = (expressServer, config) ->
  httpServer = http.createServer expressServer
  httpServer.listen p = config.get("port") ? 8083
  console.log "listening on http port %d", p
  httpServer

