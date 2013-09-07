bindable = require "bindable"

module.exports = (models) ->
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
        description: test.title,
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

      models.set {
        failureCount: failureCount
        successCount: successCount
      }

      if test.error
        models.addLog {
          description: test.error.message,
          type: "error"
        }


      