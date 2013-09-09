express    = require "express"
httpProxy  = require "http-proxy"
Url        = require "url"


# other middleware is loaded in so that it has priority over this plugin
exports.require = ["express.server", "config", "http.public", "sock.server"]
exports.plugin = (app, config) ->

  urlInfo = Url.parse config.get "proxy"


  proxy = new httpProxy.RoutingProxy()
  app.all "/**", (req, res) ->
    proxy.proxyRequest(req, res, {
      host: urlInfo.hostname,
      port: urlInfo.port
    })
