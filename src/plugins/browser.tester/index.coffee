async = require "async"
Tester = require "./tester"
Url    = require "url"

exports.require = ["browser.launchers.*", "sock.clients", "tests", "config", "pubsub"]
exports.plugin = (launcher, clients, tests, config, pubsub) ->
  browsers = config.get("browsers") or []
  limit    = config.get("limit") or 1

  proxyInfo = Url.parse(config.get("proxy"))

  ops = {
    host: config.get("host") ? proxyInfo.hostname ? "localhost",
    port: config.get("port")
  }

  return unless browsers.length

  running = false
  tester =
    run: () ->
      return if running
      running = true
      async.eachLimit browsers, limit, ((browser, next) ->
        tester = new Tester(launcher, browser, clients, pubsub, ops).run next
      ), (err) ->

        running = false
        hasError = false

        if err?
          hasError = true
        else
          console.log "completed tests without errors"


  pubsub.subscribe "init", tester.run



