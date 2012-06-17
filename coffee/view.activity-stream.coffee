jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.ActivityStream = Backbone.View.extend

  services: [
    url: 'http://api.twitter.com/1/statuses/user_timeline.json?screen_name=jarred&callback=?'
    type: 'twitter'
  ,
    url: 'http://api.tumblr.com/v2/blog/jarredbishop.tumblr.com/posts?api_key=YgpsEXCrpCtKL9U7aNBzWeDp0sSbZw1AeZQSt5QgsXRLdb5o24&jsonp=?'
    type: 'tumblr'
  ,
    url: 'http://xml2json.heroku.com?url=https://github.com/jarred.atom&callback=?'
    type: 'github'
  ]
  
  initialize: (@o) ->
    _.bindAll @
    @$el = $(@el)
    @servicesLoaded = 0
    @data = new Backbone.Collection()
    @data.comparator = @sortByDate
    @loadService 0
    return

  sortByDate: (model) ->
    return model.get('date').valueOf()

  loadService: (n) ->
    @$('.status .text').text "loading #{@services[n].type}..."
    $.ajax
      url: @services[n].url
      dataType: 'jsonp'
      success: (data) =>
        @serviceLoaded data, n
    return

  serviceLoaded: (data, index) ->
    switch @services[index].type
      when 'twitter' then @addTwitter data
      when 'tumblr' then @addTumblr data
      when 'github' then @addGithub data
    console.log 'serviceLoaded', @services[index].type
    if @servicesLoaded < @services.length - 1
      @loadService index + 1
      @servicesLoaded++
    else
      @render()
    return

  addTwitter: (data) ->
    # console.log 'addTwitter', data
    _.each data, (tweet) =>
      model = new Backbone.Model
        date: moment(tweet.created_at)
        type: 'twitter'
        data: tweet


      # console.log tweet.created_at
      # console.log model.get('date').toString()
      console.log model.toJSON()
      @data.add model
      return
    return

  addTumblr: (data) ->
    _.each data.response.posts, (post) =>
      # console.log post.date
      model = new Backbone.Model
        date: moment(post.date, 'YYYY-MM-DD HH:mm:ss')
        type: 'tumblr'
        data: post
      # console.log model.get('date').toString()
      @data.add model
      return
    console.log data
    return

  addGithub: (data) ->
    # console.log $.xmlToJSON $.parseXML data
    $data = $($.parseXML data)
    _.each $data.find('entry'), (entry) =>
      $entry = $ entry
      console.log $entry.find('published').text()
      model = new Backbone.Model
        date: moment($entry.find('published').text(), 'YYYY-MM-DD-T-HH:mm:ss')
        type: 'github'
        data: entry
      @data.add model
      console.log model.get('date').toString()
      return
    # console.log $data.find('entry')
    # console.log $data.children()
    # console.log $data[0]
    return

  render: ->
    @$el.html ""
    @data.sort()
    # Sort collection...
    _.each @data.models, (model) =>
      # console.log model.toJSON()
      @$el.append jb.Templates[model.get('type')] model.toJSON()
      return
    return