## Usage

Below is a boilerplate config file - place it in `[project_path]/.cortado.js`:

```javascript
module.exports = {

  //url to proxy when running tests - important to prevent cross-site security
  //issues
  proxy: "http://localhost:8080",

  //tests to run - these are actually loaded in the browser
  scripts: [
    __dirname + "/test/**.js"
  ],

  //data-types to cache
  cache: {
    types: ["json", "png"],
    directory: __dirname + "/test2/cache"
  },

  //files to watch, then reload
  watch: [
    __dirname + "/public/**",
    __dirname + "/test/**"
  ],

  //port to run tests on - open in http://localhost:8083/test
  port: 8083,

  //full integration 
  full: true,

  //keep the tests alive for dev mode
  keepAlive: true,

  //called each time browsers are reloaded to run tests

  events: {
    init: function() {
      exec("open http://student.classdojo.dev:8083/test?run");
    }
  }
} 
```

Next, you can start writing tests using mocha. Here's an example test from `[project_path]/tests/login-test.js`:


```
var assert = require("./helpers/assert"),
xpaths     = require("./helpers/xpaths"),
config     = require("./helpers/config"),
utils      = require("./helpers/utils"),
logout     = require("./helpers/logout");

describe("login#", function() {


  before(function(next) {
    actions.
    wait(logout()).
    then(next);
  }); 

  var p = {},
  app = xpaths.app,
  user = config.users.withoutPoints.username,
  pass = config.users.withoutPoints.password;

  /** 
   */

  it("login button toggles properly depending on input data", function(next) {

    actions.

    //test incomplete
    type(p.un = xpaths.login.usernameInput, "craigers").
    type(p.pn = xpaths.login.passwordInput, "").

    wait(assert.enabled(p.sub = app.find().eq("@type", "submit"))).

    then(next);
  }); 
  
  /**
   */
   
  it("shows a not found error", function(next) {
    actions.
    type(p.un, String(Date.now())).
    type(p.pn, "password").
    click(p.sub).
    wait(assert.textPresent("Couldn't find a user with that username.")).
    then(next);
  });
});
```

Finally, go ahead and run cortado:

```bash
cortado start
```

