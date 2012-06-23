jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.instapaper = Backbone.View.extend

  className: 'block instapaper double-height'
  
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

    console.log @$('h2').height()
    return

  template: _.template """
  <div class="content">
    <h2><a href="<%= data.link %>"><%= data.title %></a></h2>
    <div class="lines-illustration">
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
    </div>
  </div>
  """