jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.tumblr = Backbone.View.extend
  
  initialize: (@options) ->
    _.bindAll @
    @$el = $(@el)
    @render()
    return

  render: ->
    # console.log @model.get('data').type
    console.log @model.toJSON()
    @$el.html @template @model.toJSON()
    @$el.append jb.Templates.favicon @model.toJSON()
    switch @model.get('data').type
      when 'photo' then @setupPhoto()
    return

  setupPhoto: ->
    _.each @$('.images .image'), (el, index) =>
      $el = $(el)
      return if index <= 0
      radius = 100
      $el.css
        marginLeft: Math.round radius / 2 - Math.random() * radius
        marginTop: Math.round radius / 2 - Math.random() * radius
      return
    return

  template: _.template """
  <label>posted</label>
  <div class="content">
    <% if(data.type === 'photo'){ %>
      <div class="images">
        <% _.each(data.photos, function (photo){ %>
          <div class="image" style="background-image:url('<%= photo.alt_sizes[1].url %>');"></div>
        <% }); %>
      </div>
    <% } %>
    <% if(data.type === 'quote'){ %>
      <blockquote><%= data.text %></blockquote>
      <% if(data.source){ %>
        <p class="source">&mdash; <%= data.source %></p>
      <% } %>
    <% } %>
  </div>
  """