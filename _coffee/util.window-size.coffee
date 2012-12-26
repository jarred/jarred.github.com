showWindowSize =
	init: ->
		_.bindAll @
		@$el = $ "<div class=\"window-size\"></div>"
		$("body").append @$el
		$(window).bind "resize", @onResize
		@onResize()
		return

	onResize: (e) ->
		w = $(window).width()
		@$el.html Math.round(w)
		return

showWindowSize.init()