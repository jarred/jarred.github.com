jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.twitter = Backbone.View.extend

  className: 'block twitter double-width'
  
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
    <div class="content"><p class="tweet"><%= window.twttr.txt.autoLink(data.text) %></p></div>
  """