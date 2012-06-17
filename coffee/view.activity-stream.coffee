jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.ActivityStream = Backbone.View.extend

  services: [
    type: 'twitter'
    url: 'http://api.twitter.com/1/statuses/user_timeline.json?screen_name=jarred&callback=?'
    favicon: 'http://g.etfv.co/http://twitter.com'
  ,
    type: 'tumblr'
    url: 'http://api.tumblr.com/v2/blog/jarredbishop.tumblr.com/posts?api_key=YgpsEXCrpCtKL9U7aNBzWeDp0sSbZw1AeZQSt5QgsXRLdb5o24&jsonp=?'
    favicon: 'http://g.etfv.co/http://tumblr.com'
  ,
    type: 'github'
    url: 'http://xml2json.heroku.com?url=https://github.com/jarred.atom&callback=?'
    favicon: 'http://g.etfv.co/http://github.com'
  ,
    type: 'dribbble'
    url: 'http://xml2json.heroku.com?url=http://dribbble.com/jarred/shots.rss&callback=?'
    favicon: 'http://g.etfv.co/http://dribbble.com'
  ,
    type: 'instapaper'
    url: 'http://xml2json.heroku.com?url=http://www.instapaper.com/archive/rss/242/TS2f4M11DxVeYjmNcnZSG6XDk&callback=?'
    favicon: 'http://g.etfv.co/http://instapaper.com'
  ]
  
  initialize: (@o) ->
    _.bindAll @
    @$el = $(@el)
    @servicesLoaded = 0
    @data = new Backbone.Collection()
    @data.comparator = @sortByDate
    @setupPreloader()
    @loadService 0
    return

  sortByDate: (model) ->
    return -model.get('date').valueOf()

  setupPreloader: ->
    _.each @services, (service) =>
      @$('.status i.icon .favicons').append "<div class=\"favicon\" style=\"background-image: url('#{service.favicon}');\"></div>"
      return
    return

  loadService: (n) ->
    @$('.status .text').text "loading #{@services[n].type}..."
    @$('.status i.icon .favicons').animate
      top: 2 - (20 * n)
    , 200
    $.ajax
      url: @services[n].url
      dataType: 'jsonp'
      success: (data) =>
        @serviceLoaded data, n
    return

  serviceLoaded: (data, index) ->
    @loadIndex = index
    @service = @services[index]
    # console.log service
    @$el.bind "#{@service.type}-ready", @whatNext

    switch @services[index].type
      when 'twitter' then @addTwitter data
      when 'tumblr' then @addTumblr data
      when 'github' then @addGithub data
      when 'dribbble' then @addDribbble data
      when 'instapaper' then @addInstapaper data
    return

  whatNext: ->
    if @servicesLoaded < @services.length - 1
      @loadService @loadIndex + 1
      @servicesLoaded++
    else
      @render()
    return

  addTwitter: (data) ->
    _.each data, (tweet) =>
      model = new Backbone.Model
        date: moment(tweet.created_at)
        type: 'twitter'
        data: tweet
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'twitter-ready'
    return

  addTumblr: (data) ->
    _.each data.response.posts, (post) =>
      model = new Backbone.Model
        date: moment(post.date, 'YYYY-MM-DD HH:mm:ss')
        type: 'tumblr'
        data: post
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'tumblr-ready'
    return

  addGithub: (data) ->
    $data = $($.parseXML data)
    _.each $data.find('entry'), (entry) =>
      $entry = $ entry
      model = new Backbone.Model
        date: moment($entry.find('published').text(), 'YYYY-MM-DD-T-HH:mm:ss')
        type: 'github'
        data: entry
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'github-ready'
    return

  addDribbble: (data) ->
    $data = $($.parseXML data)
    _.each $data.find('item'), (item) =>
      console.log item
      $item = $ item
      model = new Backbone.Model
        date: moment($item.find('pubDate').text())
        type: 'dribbble'
        data: item
        image: $item.find('description').text()
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'dribbble-ready'
    return

  addInstapaper: (data) ->
    @$el.trigger 'instapaper-ready'
    return

  render: ->
    @$el.html ""
    @data.sort()
    # Sort collection...
    _.each @data.models, (model) =>
      # @$el.append jb.Templates[model.get('type')] model.toJSON()
      if jb.Views[model.get('type')] == undefined
        console.log "new view for #{model.get('type')}"
        return
      view = new jb.Views[model.get('type')]
        model: model
        className: "item #{model.get('type')}"
      @$el.append view.el
      return
    return