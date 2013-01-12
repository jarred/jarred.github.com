jb = window.JB ||= {}
jb.Views ||= {}
jb.Main =
	init: ->
		_.bindAll @
		@appModel = new Backbone.Model JSON.parse $('#init-data').html()
		console.log @appModel.toJSON()
		$('body').css
			paddingBottom: "#{$(window).height()}px"
		@extendViews()
		@showPost 0
		$(window).bind 'scroll', @onScroll
		return

	onScroll: (e) ->
		y = $(window).scrollTop()
		# console.log y
		x = jb.Utils.restrictNumber Math.floor(y/400), 0, @appModel.get('total_posts')
		if @currentPostIndex != x
			@showPost x
		return

	showPost: (x) ->
		@currentPostIndex = x
		console.log 'showPost', arguments
		_.each $('.post'), (el, index) =>
			$el = $(el)
			if index == @currentPostIndex
				$el.removeClass 'hide'
				$el.trigger('transition-in')
			else
				$el.addClass 'hide'
				$el.trigger('transition-out')
			return
		return

	extendViews: ->
		_.each $('.extend'), (el) =>
			$el = $(el)
			name = $el.data('view')
			return if name is null or name is ''
			return if jb.Views[name] is undefined
			view = new jb.Views[name]
				el: $el
				appModel: jb.Main.appModel
			$el.removeClass 'extend'
			return
		return

jb.Main.init()