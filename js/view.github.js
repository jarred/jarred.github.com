(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Views || (jb.Views = {});

  jb.Views.github = Backbone.View.extend({
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
    template: _.template("<div class=\"content\"><%= data.childNodes[9].textContent %></div>")
  });

}).call(this);
