(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Views.ActivityStream = Backbone.View.extend({
    services: [
      {
        url: 'http://api.twitter.com/1/statuses/user_timeline.json?screen_name=jarred&callback=?',
        type: 'twitter'
      }, {
        url: 'http://api.tumblr.com/v2/blog/jarredbishop.tumblr.com/posts?api_key=YgpsEXCrpCtKL9U7aNBzWeDp0sSbZw1AeZQSt5QgsXRLdb5o24&jsonp=?',
        type: 'tumblr'
      }, {
        url: 'http://xml2json.heroku.com?url=https://github.com/jarred.atom&callback=?',
        type: 'github'
      }
    ],
    initialize: function(o) {
      this.o = o;
      _.bindAll(this);
      this.$el = $(this.el);
      this.servicesLoaded = 0;
      this.data = new Backbone.Collection();
      this.data.comparator = this.sortByDate;
      this.loadService(0);
    },
    sortByDate: function(model) {
      return model.get('date').valueOf();
    },
    loadService: function(n) {
      var _this = this;
      this.$('.status .text').text("loading " + this.services[n].type + "...");
      $.ajax({
        url: this.services[n].url,
        dataType: 'jsonp',
        success: function(data) {
          return _this.serviceLoaded(data, n);
        }
      });
    },
    serviceLoaded: function(data, index) {
      switch (this.services[index].type) {
        case 'twitter':
          this.addTwitter(data);
          break;
        case 'tumblr':
          this.addTumblr(data);
          break;
        case 'github':
          this.addGithub(data);
      }
      console.log('serviceLoaded', this.services[index].type);
      if (this.servicesLoaded < this.services.length - 1) {
        this.loadService(index + 1);
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
          data: tweet
        });
        console.log(model.toJSON());
        _this.data.add(model);
      });
    },
    addTumblr: function(data) {
      var _this = this;
      _.each(data.response.posts, function(post) {
        var model;
        model = new Backbone.Model({
          date: moment(post.date, 'YYYY-MM-DD HH:mm:ss'),
          type: 'tumblr',
          data: post
        });
        _this.data.add(model);
      });
      console.log(data);
    },
    addGithub: function(data) {
      var $data,
        _this = this;
      $data = $($.parseXML(data));
      _.each($data.find('entry'), function(entry) {
        var $entry, model;
        $entry = $(entry);
        console.log($entry.find('published').text());
        model = new Backbone.Model({
          date: moment($entry.find('published').text(), 'YYYY-MM-DD-T-HH:mm:ss'),
          type: 'github',
          data: entry
        });
        _this.data.add(model);
        console.log(model.get('date').toString());
      });
    },
    render: function() {
      var _this = this;
      this.$el.html("");
      this.data.sort();
      _.each(this.data.models, function(model) {
        _this.$el.append(jb.Templates[model.get('type')](model.toJSON()));
      });
    }
  });

}).call(this);
