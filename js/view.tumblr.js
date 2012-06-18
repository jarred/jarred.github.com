(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Views.tumblr = Backbone.View.extend({
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
    template: _.template("<div class=\"content\">\n  <% if(data.type === 'photo'){ %>\n    <div class=\"image\"><img src=\"<%= data.photos[0].alt_sizes[2].url %>\" /></div>\n  <% } %>\n  <% if(data.type === 'quote'){ %>\n    <blockquote><%= data.text %></blockquote>\n    <% if(data.source){ %>\n      <p class=\"source\">&mdash; <%= data.source %></p>\n    <% } %>\n  <% } %>\n</div>")
  });

}).call(this);
