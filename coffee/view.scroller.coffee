jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.Scroller = Backbone.View.extend
  
  initialize: (@o) ->
    return
    _.bindAll @
    @$el = $(@el)
    @$el.addClass 'hide'
    setInterval @position, 20
    # $(document).bind 'scroll', @position
    return

  position: ->
    y = $('body').scrollTop() || 0
    h = $(document).height() - $(window).height() || 0
    pc = Math.round (y/h) * 100
    newY = pc * h
    # console.log pc
    @$el.css
      top: "#{newY}"
    return