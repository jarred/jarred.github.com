jb = window.JB ||= {}
jb.Utils ||= {}
jb.Utils.restrictNumber = (value, min, max) ->
	if value >= min && value <= max
		return value
	else if value <= min
		return min
	else if value >= max
		return max
	return