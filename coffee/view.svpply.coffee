jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.svpply = Backbone.View.extend
  
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
    <div class="content">
      <a href="<%= data.page_url %>"><img src="<%= data.image %>" /></a>
    </div>
  """