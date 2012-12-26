jb = window.JB ||= {}
jb.Views ||= {}
jb.Main =
	init: ->
		$('.post h1').lettering('words')
		return

jb.Main.init()