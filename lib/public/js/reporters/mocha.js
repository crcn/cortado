// Generated by CoffeeScript 1.6.3
var bindable, _getFullTitle;

bindable = require("bindable");

_getFullTitle = function(test) {
  var buffer, p;
  buffer = [];
  p = test;
  while (p) {
    buffer.unshift(p.title);
    p = p.parent;
  }
  return buffer.join(" ");
};

module.exports = function(models, client) {
  return function(runner) {
    var current, durInterval, duration, failureCount, successCount;
    current = void 0;
    successCount = 0;
    failureCount = 0;
    duration = 0;
    durInterval = setInterval((function() {
      return models.set("testDuration", "" + (++duration) + " s");
    }), 1000);
    runner.on("start", function() {});
    runner.on("end", function() {
      return clearTimeout(durInterval);
    });
    runner.on("test", function(test) {
      return current = models.addLog({
        description: _getFullTitle(test),
        type: "test",
        state: test.state,
        pending: true
      });
    });
    runner.on("fail", function(test, err) {
      return test.error = err;
    });
    return runner.on("test end", function(test) {
      var err, skipped;
      if (test.error) {
        failureCount++;
      } else {
        successCount++;
      }
      skipped = test.pending === true;
      current.set({
        time: skipped ? 0 : test.duration,
        pending: false,
        success: test.state === "passed",
        state: test.state
      });
      if (test.error) {
        err = {
          message: test.error.message
        };
      }
      client.send({
        event: "test",
        description: current.get("description"),
        error: err
      });
      models.set({
        failureCount: failureCount,
        successCount: successCount
      });
      if (test.error) {
        return models.addLog({
          description: test.error.message,
          type: "error"
        });
      }
    });
  };
};