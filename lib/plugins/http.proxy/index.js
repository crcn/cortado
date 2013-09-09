// Generated by CoffeeScript 1.6.3
var Url, express, httpProxy;

express = require("express");

httpProxy = require("http-proxy");

Url = require("url");

exports.require = ["express.server", "config", "http.public", "sock.server"];

exports.plugin = function(app, config) {
  var proxy, urlInfo;
  urlInfo = Url.parse(config.get("proxy"));
  proxy = new httpProxy.RoutingProxy();
  return app.all("/**", function(req, res) {
    return proxy.proxyRequest(req, res, {
      host: urlInfo.hostname,
      port: urlInfo.port
    });
  });
};