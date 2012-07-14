// Generated by CoffeeScript 1.3.3
(function() {
  var jb;

  jb = window.JB || (window.JB = {});

  jb.Collections || (jb.Collections = {});

  jb.Collections.Items = Backbone.Collection.extend({
    initialize: function(options) {
      this.maxOld = moment().subtract('days', 10);
    },
    add: function(item) {
      var d;
      d = item.get('date');
      if (d > this.maxOld) {
        Backbone.Collection.prototype.add.call(this, item);
      }
    }
  });

}).call(this);