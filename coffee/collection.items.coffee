jb = window.JB ||= {}
jb.Collections ||= {}
jb.Collections.Items = Backbone.Collection.extend
  
  initialize: (options) ->
    @maxOld = moment().subtract('days', 10)
    return

  add: (item) ->
    d = item.get('date')
    if d > @maxOld
      Backbone.Collection.prototype.add.call(this, item);
    return

