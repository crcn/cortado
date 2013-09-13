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
    errors       = []


    durInterval = setInterval (() ->
      models.set "testDuration", "#{++duration} s"
    ), 1000

    runner.on "start", () ->
      client.send { event: "startTests" }
    runner.on "end", () ->
      clearTimeout durInterval
      client.send { 
        event: "endTests", 
        data: {
          errors: errors,
          successCount: successCount, 
          failureCount: failureCount,
          duration: duration
        }
      }

    runner.on "fail", (test, err) ->
      test.error = err
      if test.type is "hook" or err?.uncaught
        runner.emit "test end", test

    runner.on "test end", (test) ->


      if test.error
        failureCount++
      else
        successCount++

      skipped = test.pending is true

      models.addLog {
        description: desc = _getFullTitle(test),
        type: "test",
        state: test.state,
        pending: false,
        success: test.state is "passed",
        time: if skipped then 0 else test.duration,
      }

      if test.error 
        err = {
          message: test.error.message
        }
        errors.push err

      client.send { 
        event: "test", 
        data: {
          description: desc,
          error: err
        }
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

        client.send {
          event: "fail",
          data: err
        }