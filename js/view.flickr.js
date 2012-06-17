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
      console.log(this.model.toJSON());
      this.$el.html(this.template(this.model.toJSON()));
      this.$el.append(jb.Templates.favicon(this.model.toJSON()));
    },
    template: _.template("<a href=\"http://flickr.com/photo.gne?id=<%= data.id %>\"><img src=\"http://farm<%= data.farm %>.static.flickr.com/<%= data.server %>/<%= data.id %>_<%= data.secret %>_m.jpg\"></a>")
  });

}).call(this);
