jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.ActivityStream = Backbone.View.extend

  services: [
    type: 'lookwork'
    url: 'http://xml2json.heroku.com?url=http://lookwork.com/jarred/library.rss&callback=?'
    favicon: 'http://lookwork.com/assets/images/favicon.png'
  ,
    type: 'twitter'
    url: 'http://api.twitter.com/1/statuses/user_timeline.json?screen_name=jarred&callback=?'
    favicon: 'http://g.etfv.co/http://twitter.com'
  ,
    type: 'instapaper'
    url: 'http://xml2json.heroku.com?url=http://www.instapaper.com/archive/rss/242/TS2f4M11DxVeYjmNcnZSG6XDk&callback=?'
    favicon: 'http://g.etfv.co/http://instapaper.com'
  ,
    type: 'github'
    url: 'http://xml2json.heroku.com?url=https://github.com/jarred.atom&callback=?'
    favicon: 'http://g.etfv.co/http://github.com'
  ,
    type: 'tumblr'
    url: 'http://api.tumblr.com/v2/blog/jarredbishop.tumblr.com/posts?api_key=YgpsEXCrpCtKL9U7aNBzWeDp0sSbZw1AeZQSt5QgsXRLdb5o24&jsonp=?'
    favicon: 'http://g.etfv.co/http://tumblr.com'
  ,
    type: 'dribbble'
    url: 'http://xml2json.heroku.com?url=http://dribbble.com/jarred/shots.rss&callback=?'
    favicon: 'http://g.etfv.co/http://dribbble.com'
  ,
    type: 'flickr'
    url: 'http://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=85497dbe3823d30b7db8ce79b3bc9ab3&user_id=72904000%40N00&per_page=20&page=0&format=json&extras=date_taken&jsoncallback=?'
    favicon: 'http://l.yimg.com/g/favicon.ico'
  ,
    type: 'svpply'
    url: 'https://api.svpply.com/v1/users/jarred/wants/products.json?limit=20&callback=?'
    favicon: 'http://g.etfv.co/http://svpply.com'
  ,
    type: 'pinboard'
    url: 'http://xml2json.heroku.com?url=http://feeds.pinboard.in/rss/secret:f06efe78d64f6c8a98b3/u:jarred/&callback=?'
    favicon: 'http://g.etfv.co/http://pinboard.in'
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
      top: 2 - (20 * (n + 1))
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
    @$el.bind "#{@service.type}-ready", @whatNext

    switch @services[index].type
      when 'twitter' then @addTwitter data
      when 'tumblr' then @addTumblr data
      when 'github' then @addGithub data
      when 'dribbble' then @addDribbble data
      when 'instapaper' then @addInstapaper data
      when 'flickr' then @addFlickr data
      when 'svpply' then @addSvpply data
      when 'pinboard' then @addPinboard data
      when 'lookwork' then @addLookwork data
    return

  whatNext: ->
    @render()

    if @servicesLoaded < @services.length - 1
      @loadService @loadIndex + 1
      @servicesLoaded++
    else
      @$('.status').addClass 'hide'
      # @render()
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
        data:
          title: $entry.find('title').text()
          content: $entry.find('content').text()
          link: $entry.find('link').attr('href')
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'github-ready'
    return

  addDribbble: (data) ->
    $data = $($.parseXML data)
    _.each $data.find('item'), (item) =>
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
    # console.log data
    $data = $($.parseXML data)
    _.each $data.find('item'), (entry) =>
      $entry = $ entry
      model = new Backbone.Model
        date: moment($entry.find('pubDate').text())
        type: 'instapaper'
        favicon: @service.favicon
        data:
          title: $entry.find('title').text()
          link: $entry.find('link').text()
          description: $entry.find('description').text()
      @data.add model
      return
    @$el.trigger 'instapaper-ready'
    return

  addFlickr: (data) ->
    _.each data.photos.photo, (photo) =>
      model = new Backbone.Model
        date: moment(photo.datetaken, 'YYYY-MM-DD HH:mm:ss')
        type: 'flickr'
        data: photo
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'flickr-ready'
    return

  addSvpply: (data) ->
    _.each data.response.products, (product) =>
      model = new Backbone.Model
        date: moment(product.date_created, 'YYYY-MM-DD HH:mm:ss')
        type: 'svpply'
        data: product
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'svpply-ready'
    return

  addPinboard: (data) ->
    $data = $($.parseXML data)
    # console.log data['rdf:RDF'].item
    _.each data['rdf:RDF'].item, (item) =>
      model = new Backbone.Model
        date: moment(item['dc:date'], 'YYYY-MM-DDTHH:mm:ss')
        type: 'pinboard'
        favicon: @service.favicon
        data:
          title: item.title
          link: item.link
      if model.get('data').title.indexOf('[priv]') == -1
        @data.add model
      return
    @$el.trigger 'pinboard-ready'
    return

  addLookwork: (data) ->
    $data = $($(data)[1].nextSibling)
    _.each $data.find('item'), (item) =>
      $item = $(item)
      console.log $item
      model = new Backbone.Model
        type: 'lookwork'
        date: moment($item.find('pubDate').text())
        content: String($item.find('description').html()).replace("<!--[CDATA[", "").replace("]]>", "").replace("]]>", "")
        favicon: @service.favicon
      @data.add model
      return
    @$el.trigger 'lookwork-ready'
    return
    # $data = $($.parseXML data)
    $data = $(data)[2]
    console.log $data
    _.each $data.find('item'), (item) =>
      console.log item
      return
    @$el.trigger 'lookwork-ready'
    return

  render: ->
    @$('.items').html ''
    @data.sort()
    # @data.models = _.shuffle @data.models
    # Sort collection...
    _.each @data.models, (model, index) =>
      # @$el.append jb.Templates[model.get('type')] model.toJSON()
      if jb.Views[model.get('type')] == undefined
        console.log "new view for #{model.get('type')}"
        return
      view = new jb.Views[model.get('type')]
        model: model
        className: "item #{model.get('type')}"
      $el = $(view.el)
      @$('.items').append view.el
      if index%2 == 0
        $el.addClass 'left'
      else
        $el.addClass 'right'
      return
    return