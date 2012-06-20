jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.lookwork = Backbone.View.extend
  
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
    <label>saved</label>
    <div class="content"><%= content %></div>
  """