jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.flickr = Backbone.View.extend
  
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
    <a href=\"http://flickr.com/photo.gne?id=<%= data.id %>\"><img src=\"http://farm<%= data.farm %>.static.flickr.com/<%= data.server %>/<%= data.id %>_<%= data.secret %>_m.jpg\"></a>
  </div>
  """