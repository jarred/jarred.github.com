(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Views.flickr = Backbone.View.extend({
    initialize: function(options) {
      this.options = options;
      _.bindAll(this);
      this.$el = $(this.el);
      this.render();
    },
    render: function() {
      this.$el.html(this.template(this.model.toJSON()));
      this.$el.append(jb.Templates.favicon(this.model.toJSON()));
    },
    template: _.template("<div class=\"content\">\n  <a href=\"http://flickr.com/photo.gne?id=<%= data.id %>\"><img src=\"http://farm<%= data.farm %>.static.flickr.com/<%= data.server %>/<%= data.id %>_<%= data.secret %>_m.jpg\"></a>\n</div>")
  });

}).call(this);
