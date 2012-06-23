// Generated by CoffeeScript 1.3.3
(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Views.flickr = Backbone.View.extend({
    className: 'block flickr double-height double-width',
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
    template: _.template("<div class=\"content\" style=\"background-image:url('http://farm<%= data.farm %>.static.flickr.com/<%= data.server %>/<%= data.id %>_<%= data.secret %>_z.jpg');\">\n\n</div>")
  });

}).call(this);
