// Generated by CoffeeScript 1.3.3
(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Views.lookwork = Backbone.View.extend({
    initialize: function(options) {
      this.options = options;
      _.bindAll(this);
      this.$el = $(this.el);
      this.render();
    },
    render: function() {
      var img;
      this.$el.html(this.template(this.model.toJSON()));
      this.$el.append(jb.Templates.favicon(this.model.toJSON()));
      img = new Image();
      img.src = this.$('img').attr('src');
      this.$('.content').html(img);
    },
    template: _.template("<label>saved</label>\n<div class=\"content\"><%= content %></div>")
  });

}).call(this);
