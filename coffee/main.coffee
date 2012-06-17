jb = window.JB ||= {}
jb.Views ||= {}
jb.Main =

  loadLibs: ->
    require [
      "http://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.2/jquery.min.js"
      "http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min.js"
      "http://cdnjs.cloudflare.com/ajax/libs/json3/3.2.2/json3.min.js"
    ], () =>
      require [
        "http://cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.2/backbone-min.js"
        "js/moment.min"
        "js/templates"
        # 'js/xml2json'     # https://github.com/bytespider/XML2JSON
        'js/jqXMLUtils'
      ], () =>
        require [
          "js/view.activity-stream"
        ], () =>
          @init()
          return
    return

  init: ->
    @extendViews()
    return

  extendViews: ->
    _.each $('.extend'), (el) =>
      $el = $(el)
      name = $el.data('view')
      return if name is null or name is ''
      return if jb.Views[name] is undefined
      view = new jb.Views[name]
        el: $el
      $el.removeClass 'extend'
      return
    return

jb.Main.loadLibs()