async = require "async"
Tester = require "./tester"

exports.require = ["browser.launchers.*", "sock.clients", "tests", "config", "pubsub"]
exports.plugin = (launcher, clients, tests, config, pubsub) ->
  browsers = config.get("browsers") or []
  limit    = config.get("limit") or 1

  return unless browsers.length

  running = false
  tester =
    run: () ->
      return if running
      running = true
      async.eachLimit browsers, limit, ((browser, next) ->
        tester = new Tester(launcher, browser, clients, pubsub).run next
      ), (err) ->

        running = false
        hasError = false

        if err?
          hasError = true
        else
          console.log "completed tests without errors"


  pubsub.subscribe "init", tester.run



