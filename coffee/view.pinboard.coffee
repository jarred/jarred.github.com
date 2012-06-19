jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.pinboard = Backbone.View.extend
  
  initialize: (@options) ->
    _.bindAll @
    @$el = $(@el)
    @render()
    return

  render: ->
    # console.log @model.get('data').type
    # console.log @model.toJSON()
    @$el.html @template @model.toJSON()
    @$el.append jb.Templates.favicon @model.toJSON()
    return

  template: _.template """
  <label>saved</label>
  <div class="content">
    <h2><a href="<%= data.link %>"><%= data.title %></a></h2>
  </div>
  """