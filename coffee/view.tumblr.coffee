jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.tumblr = Backbone.View.extend
  
  initialize: (@options) ->
    _.bindAll @
    @$el = $(@el)
    @render()
    return

  render: ->
    # console.log @model.toJSON()
    @$el.html @template @model.toJSON()
    @$el.append jb.Templates.favicon @model.toJSON()
    return

  template: _.template """
    tumblr post, <%= data.type %>
    <% if(data.type === 'photo'){ %>
      <div class="image"><img src="<%= data.photos[0].alt_sizes[2].url %>" /></div>
    <% } %>
  """