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

    setTimeout @waitForRenderAndUpdate, 1
    # @waitForRenderAndUpdate()
    return

  waitForRenderAndUpdate: ->
    headingLines = @$('h2').height() / 20
    _.each @$('.line'), (el, index) ->
      if index > (13 - headingLines)
        $(el).remove()
      return
    @$('.line:last').css
      width: '30%'
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