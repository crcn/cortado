sockjs = require "sockjs"

exports.require = ["http.server"]
exports.load = (httpServer) ->
  sock = sockjs.createServer({sockjs_url: "http://cdn.sockjs.org/sockjs-0.3.min.js", log: () -> })
  sock.installHandlers(httpServer, { prefix: "/sock" })
  sock
