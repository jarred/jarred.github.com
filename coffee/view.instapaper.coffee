jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.instapaper = Backbone.View.extend
  
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
  <div class="content">
    <h2><label>read</label><a href="<%= data.link %>"><%= data.title %></a></h2>
  </div>
  """