(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Templates = {
    favicon: _.template("<div class=\"connection\"></div>\n<div class=\"favicon\">\n  <img src=\"<%= favicon %>\" />\n</div>")
  };

}).call(this);
