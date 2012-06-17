(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Templates = {
    twitter: _.template("<div class=\"item\"><%= data.text %></div>"),
    tumblr: _.template("<div class=\"item\">this is a blog post...</div>"),
    github: _.template("<div class=\"item\">and now github?</div>")
  };

}).call(this);
