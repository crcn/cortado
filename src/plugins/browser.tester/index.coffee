async = require "async"
Tester = require "./tester"

exports.require = ["browser.launchers.*", "sock.clients", "tests", "config", "pubsub"]
exports.plugin = (launcher, clients, tests, config, pubsub) ->
  browsers = config.get("browsers") or []
  limit    = config.get("limit") or 1

  running = false
  tester =
    run: () ->
      return if running
      running = true
      async.eachLimit browsers, limit, ((browser, next) ->
        tester = new Tester(launcher, browser, clients, pubsub).run next
        tester.on "error", (data) ->
          pubsub.publish "error", data
      ), (err) ->

        running = false
        hasError = false

        if err?
          console.error err.message
          hasError = true
        else
          console.log "completed tests without errors"

        unless config.get("keepAlive")
          process.exit(Number(hasError))

  tests.on "bundle", tester.run
  tester



