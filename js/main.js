(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Main = {
    loadLibs: function() {
      var _this = this;
      require(["http://cdnjs.cloudflare.com/ajax/libs/jquery/1.7.2/jquery.min.js", "http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min.js", "http://cdnjs.cloudflare.com/ajax/libs/json3/3.2.2/json3.min.js", "js/twitter-text.js"], function() {
        return require(["http://cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.2/backbone-min.js", "js/moment.min", "js/templates"], function() {
          return require(["js/view.twitter", "js/view.tumblr", "js/view.github", "js/view.flickr", "js/view.dribbble", "js/view.svpply", "js/view.activity-stream"], function() {
            _this.init();
          });
        });
      });
    },
    init: function() {
      this.extendViews();
    },
    extendViews: function() {
      var _this = this;
      _.each($('.extend'), function(el) {
        var $el, name, view;
        $el = $(el);
        name = $el.data('view');
        if (name === null || name === '') return;
        if (jb.Views[name] === void 0) return;
        view = new jb.Views[name]({
          el: $el
        });
        $el.removeClass('extend');
      });
    }
  };

  jb.Main.loadLibs();

}).call(this);
