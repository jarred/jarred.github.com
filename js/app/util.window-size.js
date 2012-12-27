// Generated by CoffeeScript 1.3.3
(function() {
  var showWindowSize;

  showWindowSize = {
    init: function() {
      _.bindAll(this);
      this.$el = $("<div class=\"window-size\"></div>");
      $("body").append(this.$el);
      $(window).bind("resize", this.onResize);
      this.onResize();
    },
    onResize: function(e) {
      var w;
      w = $(window).width();
      this.$el.html(Math.round(w));
    }
  };

  showWindowSize.init();

}).call(this);