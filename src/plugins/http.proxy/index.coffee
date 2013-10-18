express    = require "express"
httpProxy  = require "http-proxy"
Url        = require "url"


# other middleware is loaded in so that it has priority over this plugin
exports.require = ["express.server", "config", "http.public", "sock.server"]
exports.load = (app, config, pubsub) ->

  urlInfo = Url.parse config.get "proxy"


  proxy = new httpProxy.RoutingProxy()

  # fix issue with 302 redirect when location is http,http://domain.com
  proxy.on "start", (req, res, target) ->
    oldRequest = target.protocol.request
    return if oldRequest.__shimed
    target.protocol.request = (req, cb) ->
      oldRequest.call target.protocol, req, (res) ->
        if res.statusCode in [301, 302] and res.headers.location
          res.headers.location = res.headers.location.replace("http,", "")
        cb res

    target.protocol.request.__shimed = true

  pubsub.on "init", () ->


    app.all "/**", (req, res) ->
      p = proxy.proxyRequest(req, res, {
        host: urlInfo.hostname,
        port: urlInfo.port
      })


