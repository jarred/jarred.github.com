jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.github = Backbone.View.extend

  className: 'block github double-width'
  
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
      <div class="numbers">
        <span class="number">&nbsp;</span>
          <span class="number">0</span>
          <span class="number">1</span>
          <span class="number">2</span>
          <span class="number">3</span>
          <span class="number">4</span>
          <span class="number">5</span>
          <span class="number">6</span>
          <span class="number">7</span>
          <span class="number">8</span>
          <span class="number">9</span>
          <span class="number">10</span>
          <span class="number">11</span>
          <span class="number">12</span>
          <span class="number">13</span>
          <span class="number">14</span>
      </div>
      <div class="message">
        <%= data.content %>
      </div>
    </div>
  """