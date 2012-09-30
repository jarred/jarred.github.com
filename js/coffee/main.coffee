jb = window.JB ||= {}

jb.Info =
	init: ->
		$('#blocks').isotope
		    masonry:
		      columnWidth: 80
		return