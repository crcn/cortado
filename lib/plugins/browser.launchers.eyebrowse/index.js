// Generated by CoffeeScript 1.6.3
var eyebrowse;

eyebrowse = require("eyebrowse");

exports.require = ["config"];

exports.plugin = function(config) {
  var client;
  if (!config.get("eyebrowse")) {
    return;
  }
  client = new eyebrowse.Client(config.get("eyebrowse"));
  return {
    start: function(name, url, callback) {
      var info;
      info = name.split("@");
      return client.start({
        name: info.shift(),
        version: info.shift(),
        args: [url]
      }, callback);
    }
  };
};