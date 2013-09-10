async = require "async"
Tester = require "./tester"

exports.require = ["browser.launchers.*", "sock.clients", "tests", "config"]
exports.plugin = (launcher, clients, tests, config) ->
  browsers = config.get("browsers") or []
  limit    = config.get("limit") or 1

  tester =
    run: (next) ->
      async.eachLimit browsers, limit, ((browser, next) ->
        new Tester(launcher, browser, clients).run next
      ), (err) ->

        if err?
          console.error err.message
          process.exit(1)

        unless config.get("keepAlive")

  tests.on "bundle", tester.run
  tester



