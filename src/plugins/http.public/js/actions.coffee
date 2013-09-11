fasten   = require "fasten"
fastener = fasten()
hurryup  = require "hurryup"

trigger = (els, event) ->
  for el in els
    el.dispatchEvent new Event event

fastener.add("actions", {

  visit: 
    type: "actions"
    call: (url, next) ->
      @models.set "control.location", url
      @models.bind("control.document", () =>
        next(null, @)
      ).once().now()

  type:
    type: "actions"
    call: (path, value, next) ->
      @findElements path, (err, $elements) =>
        return next(err) if err?
        $elements.val(value)
        # trigger a change event somehow
        $elements.trigger "keydown"
        $elements.trigger "keyup"
        $elements.trigger "change"
        $elements.trigger "click"

        next null, @

  click:
    type: "actions"
    call: (path, next) ->
      @findElements path, (err, $elements) =>
        return next(err) if err?
        $elements.click()

        next null, @

  wait:
    type: "actions"
    call: (fn, next) ->

      hurryup(((next) ->

        run = (next) ->
          try 
            if fn.length is 1
              fn next
            else
              fn()
              next()
          catch err
            next err

        run next

      ), { retry: true, timeout: 1000 * 5, retryTimeout: 500 }).call @, (err) =>
        return next(err) if err?
        next null, @

  find: 
    type: "actions"
    call: (path, fn, next) -> 
      @findElements path, (err, $elements) =>
        return next(err) if err?
        try 
          fn($elements)
        catch e
          next e, @

        next null, @


})

module.exports = (models) ->
  
  target = { 
    models: models,
    findElements: (path, next) ->

      fn = hurryup ((path, next) ->

        unless cdoc = models.get("control.document")
          return next(new Error("control document is not defined"))

        try 
          $els = models.get("control.window").$ $(cdoc).xpath(path)
        catch e
          return next new Error("xpath #{path} is invalid")

        unless $els.length
          return next(new Error("no elements found for path #{path}"))

        return setTimeout (() ->
          next(null, $els)
        ), 5

      ), { 
        timeout: 1000 * 5, 
        retry: true, 
        retryTimeout: 500 
      }

      fn.call @, path, next

      @
  }



  fastener = fastener.wrap "actions", target

  models.bind "control.document", (doc) -> 
    fastener.document = doc

  models.bind "control.window", (win) ->
    fastener.window = win

  fastener.on "error", () ->
    models.addLog { description: "fail", success: false }

  fastener.on "result", (data) ->
    models.addLog { 
      description: "#{data.method}(#{data.args.join(', ')})", 
      success: true, 
      type: "action" 
    }

  fastener