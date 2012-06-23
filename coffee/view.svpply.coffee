jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.svpply = Backbone.View.extend

  className: 'block svpply'
  
  initialize: (@options) ->
    _.bindAll @
    @$el = $(@el)
    @render()
    return

  render: ->
    @$el.html @template @model.toJSON()
    @$el.append jb.Templates.favicon @model.toJSON()
    return

  template: _.template """
    <div class="content" style="background-image:url('<%= data.image %>');">
      
    </div>
  """