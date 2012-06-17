(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Templates = {
    favicon: _.template("<div class=\"favicon\">\n  <img src=\"<%= favicon %>\" />\n</div>")
  };

}).call(this);
