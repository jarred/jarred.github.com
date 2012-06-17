(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Views.ActivityStream = Backbone.View.extend({
    services: [
      {
        type: 'twitter',
        url: 'http://api.twitter.com/1/statuses/user_timeline.json?screen_name=jarred&callback=?',
        favicon: 'http://g.etfv.co/http://twitter.com'
      }, {
        type: 'tumblr',
        url: 'http://api.tumblr.com/v2/blog/jarredbishop.tumblr.com/posts?api_key=YgpsEXCrpCtKL9U7aNBzWeDp0sSbZw1AeZQSt5QgsXRLdb5o24&jsonp=?',
        favicon: 'http://g.etfv.co/http://tumblr.com'
      }, {
        type: 'github',
        url: 'http://xml2json.heroku.com?url=https://github.com/jarred.atom&callback=?',
        favicon: 'http://g.etfv.co/http://github.com'
      }, {
        type: 'dribbble',
        url: 'http://xml2json.heroku.com?url=http://dribbble.com/jarred/shots.rss&callback=?',
        favicon: 'http://g.etfv.co/http://dribbble.com'
      }, {
        type: 'instapaper',
        url: 'http://xml2json.heroku.com?url=http://www.instapaper.com/archive/rss/242/TS2f4M11DxVeYjmNcnZSG6XDk&callback=?',
        favicon: 'http://g.etfv.co/http://instapaper.com'
      }
    ],
    initialize: function(o) {
      this.o = o;
      _.bindAll(this);
      this.$el = $(this.el);
      this.servicesLoaded = 0;
      this.data = new Backbone.Collection();
      this.data.comparator = this.sortByDate;
      this.setupPreloader();
      this.loadService(0);
    },
    sortByDate: function(model) {
      return -model.get('date').valueOf();
    },
    setupPreloader: function() {
      var _this = this;
      _.each(this.services, function(service) {
        _this.$('.status i.icon .favicons').append("<div class=\"favicon\" style=\"background-image: url('" + service.favicon + "');\"></div>");
      });
    },
    loadService: function(n) {
      var _this = this;
      this.$('.status .text').text("loading " + this.services[n].type + "...");
      this.$('.status i.icon .favicons').animate({
        top: 2 - (20 * n)
      }, 200);
      $.ajax({
        url: this.services[n].url,
        dataType: 'jsonp',
        success: function(data) {
          return _this.serviceLoaded(data, n);
        }
      });
    },
    serviceLoaded: function(data, index) {
      this.loadIndex = index;
      this.service = this.services[index];
      this.$el.bind("" + this.service.type + "-ready", this.whatNext);
      switch (this.services[index].type) {
        case 'twitter':
          this.addTwitter(data);
          break;
        case 'tumblr':
          this.addTumblr(data);
          break;
        case 'github':
          this.addGithub(data);
          break;
        case 'dribbble':
          this.addDribbble(data);
          break;
        case 'instapaper':
          this.addInstapaper(data);
      }
    },
    whatNext: function() {
      if (this.servicesLoaded < this.services.length - 1) {
        this.loadService(this.loadIndex + 1);
        this.servicesLoaded++;
      } else {
        this.render();
      }
    },
    addTwitter: function(data) {
      var _this = this;
      _.each(data, function(tweet) {
        var model;
        model = new Backbone.Model({
          date: moment(tweet.created_at),
          type: 'twitter',
          data: tweet,
          favicon: _this.service.favicon
        });
        _this.data.add(model);
      });
      this.$el.trigger('twitter-ready');
    },
    addTumblr: function(data) {
      var _this = this;
      _.each(data.response.posts, function(post) {
        var model;
        model = new Backbone.Model({
          date: moment(post.date, 'YYYY-MM-DD HH:mm:ss'),
          type: 'tumblr',
          data: post,
          favicon: _this.service.favicon
        });
        _this.data.add(model);
      });
      this.$el.trigger('tumblr-ready');
    },
    addGithub: function(data) {
      var $data,
        _this = this;
      $data = $($.parseXML(data));
      _.each($data.find('entry'), function(entry) {
        var $entry, model;
        $entry = $(entry);
        model = new Backbone.Model({
          date: moment($entry.find('published').text(), 'YYYY-MM-DD-T-HH:mm:ss'),
          type: 'github',
          data: entry,
          favicon: _this.service.favicon
        });
        _this.data.add(model);
      });
      this.$el.trigger('github-ready');
    },
    addDribbble: function(data) {
      var $data,
        _this = this;
      $data = $($.parseXML(data));
      _.each($data.find('item'), function(item) {
        var $item, model;
        console.log(item);
        $item = $(item);
        model = new Backbone.Model({
          date: moment($item.find('pubDate').text()),
          type: 'dribbble',
          data: item,
          image: $item.find('description').text(),
          favicon: _this.service.favicon
        });
        _this.data.add(model);
      });
      this.$el.trigger('dribbble-ready');
    },
    addInstapaper: function(data) {
      this.$el.trigger('instapaper-ready');
    },
    render: function() {
      var _this = this;
      this.$('.status').addClass('hide');
      this.data.sort();
      _.each(this.data.models, function(model, index) {
        var view;
        if (jb.Views[model.get('type')] === void 0) {
          console.log("new view for " + (model.get('type')));
          return;
        }
        view = new jb.Views[model.get('type')]({
          model: model,
          className: "item " + (model.get('type'))
        });
        console.log(index % 2);
        if (index % 2 === 0) {
          _this.$('.column.left').append(view.el);
        } else {
          _this.$('.column.right').append(view.el);
        }
      });
    }
  });

}).call(this);
