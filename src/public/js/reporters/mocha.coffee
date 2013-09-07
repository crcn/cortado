bindable = require "bindable"


_getFullTitle = (test) ->
  buffer = []
  p = test
  while p
    buffer.unshift p.title
    p = p.parent
  buffer.join(" ")

module.exports = (models, client) ->
  (runner) ->
    current = undefined
    successCount = 0
    failureCount = 0
    duration     = 0


    durInterval = setInterval (() ->
      models.set "testDuration", "#{++duration} s"
    ), 1000

    runner.on "start", () ->
    runner.on "end", () ->
      clearTimeout durInterval

    runner.on "test", (test) ->
      current = models.addLog {
        description: _getFullTitle(test),
        type: "test",
        state: test.state,
        pending: true,
      }

    runner.on "fail", (test, err) ->
      test.error = err

    runner.on "test end", (test) ->

      if test.error
        failureCount++
      else
        successCount++

      skipped = test.pending is true
      current.set {
        time: if skipped then 0 else test.duration,
        pending: false,
        success: test.state is "passed",
        state: test.state
      }

      if test.error 
        err = {
          message: test.error.message
        }

      client.send { 
        event: "test", 
        description: current.get("description"),
        error: err
      }

      models.set {
        failureCount: failureCount
        successCount: successCount
      }

      if test.error
        models.addLog {
          description: test.error.message,
          type: "error"
        }


      