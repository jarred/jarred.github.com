jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.lookwork = Backbone.View.extend

  className: 'block lookwork'
  
  initialize: (@options) ->
    _.bindAll @
    @$el = $(@el)
    @render()
    return

  render: ->
    @$el.html @template @model.toJSON()
    @$el.append jb.Templates.favicon @model.toJSON()
    img = new Image()
    img.src = @$('img').attr('src') 
    @$('.content').html img
    return

  template: _.template """
    <label>saved</label>
    <div class="content"><%= content %></div>
  """