fasten = require "fasten"
fastener = fasten()

fastener.add("actions", {

  visit: 
    call: (url, next) ->
      @preview.location url, () => next null, @

  type:
    call: (path, value, next) ->
      @preview.findElements path, (err, $elements) =>
        return next(err) if err?
        $elements.val(value)
        $elements.trigger "keydown"
        $elements.trigger "keyup"
        next null, @

  click:
    call: (path, next) ->
      @preview.findElements path, (err, $elements) ->
        return next(err) if err?
        $elements.trigger "click"
        next null, @

  find: (path, fn, next) -> 
    @preview.findElements path, (err, $elements) ->
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

module.exports = (preview) ->
  fastener.wrap "actions", { preview: preview }