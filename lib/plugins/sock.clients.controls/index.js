// Generated by CoffeeScript 1.6.3
exports.require = ["sock.clients", "tests"];

exports.plugin = function(clients, tests) {
  var controls;
  controls = {
    reload: function() {
      return clients.emit("reload");
    }
  };
  tests.on("bundle", controls.reload);
  return controls;
};