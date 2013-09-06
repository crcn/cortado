
## Usage


You'l first need to setup cortado in a static node.js server:

```javascript
var express = require("express");
express().
use(require("cortado")()).
listen(80);
```

You can however run cortado from the command line:

```bash
cortado server --proxy http://localhost:8080
```


test/site-test.js

```javascript
var cortado = require("cortado")();
cortado.
visit("/path").
type("#username", "user").
type("#password" , "pass").
click("#login");
```