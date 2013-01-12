jb = window.JB ||= {}
jb.Views ||= {}
jb.Views.Post = Backbone.View.extend
	
	events:
		'transition-in': 'transitionIn'
	
	initialize: (@options) ->
		_.bindAll @
		# console.log 'hi'
		@model = new Backbone.Model JSON.parse @$('.post-data').html()
		# console.log @model.toJSON()
		return

	transitionIn: (e) ->
		console.log 'transitionIn'
		$('#jarred-is .what').text @model.get('jarred-is')
		return