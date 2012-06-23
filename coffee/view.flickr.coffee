jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.flickr = Backbone.View.extend

  className: 'block flickr double-height double-width'
  
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
  <div class="content" style="background-image:url('http://farm<%= data.farm %>.static.flickr.com/<%= data.server %>/<%= data.id %>_<%= data.secret %>_z.jpg');">

  </div>
  """