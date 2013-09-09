fasten   = require "fasten"
fastener = fasten()
hurryup  = require "hurryup"

fastener.add("actions", {

  visit: 
    call: (url, next) ->
      @models.set "control.location", url
      @models.bind("control.document", () =>
        next(null, @)
      ).once().now()

  type:
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
    call: (path, next) ->
      @findElements path, (err, $elements) ->
        return next(err) if err?
        $elements.trigger "click"
        next null, @

  find: (path, fn, next) -> 
    @findElements path, (err, $elements) ->
      return next(err) if err?
      try 
        fn($elements)
      catch e
        next e, @

      next null, @

  then: (fn, next) ->
    try
      fn()
    catch e
      return next(e)
    next()

})

module.exports = (models) ->
  
  target = { 
    models: models,
    findElements: (path, next) ->

      fn = hurryup ((path, next) ->

        unless cdoc = models.get("control.document")
          return next(new Error("control document is not defined"))

        try 
          $els = $(cdoc).xpath(path)
        catch e
          return next new Error("xpath #{path} is invalid")

        unless $els.length
          return next(new Error("no elements found for path #{path}"))

        return setTimeout next, 5, null, $els

      ), { 
        timeout: 1000 * 3, 
        retry: true, 
        retryTimeout: 100 
      }

      fn.call @, path, next

      @
  }
  fastener = fastener.wrap "actions", target

  fastener.on "error", () ->
    models.addLog { description: "fail", success: false }

  fastener.on "result", (data) ->
    models.addLog { 
      description: "#{data.method}(#{data.args.join(', ')})", 
      success: true, 
      type: "action" 
    }

  fastener