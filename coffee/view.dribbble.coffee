jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.dribbble = Backbone.View.extend

  className: 'block dribbble double-height'
  
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
    <div class="content">
      <img src="<%= image %>" />
    </div>
  """