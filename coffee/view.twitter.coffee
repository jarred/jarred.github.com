jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.twitter = Backbone.View.extend
  
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
    <div class="text"><%= window.twttr.txt.autoLink(data.text) %></div>
  """