jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.github = Backbone.View.extend
  
  initialize: (@options) ->
    _.bindAll @
    @$el = $(@el)
    @render()
    return

  render: ->
    # console.log @model.toJSON().data
    @$el.html @template @model.toJSON()
    @$el.append jb.Templates.favicon @model.toJSON()
    return

  template: _.template """
    <label>pushed</label>
    <div class="content">
      <%= data.content %>
    </div>
  """