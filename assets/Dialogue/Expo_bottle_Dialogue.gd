extends Resource

var dialog = {
	0: {
		# requires YORKER having been spoken to after being fixed.
		required_flag = "mystery_bottle",
		start_flag = "expo_bottle",
		dialogue = [
			'[color=gray]it\'s a glass bottle closed with a cork. there looks to be something inside...',
			'[color=gray]maybe YORKER will want to see it.',
		],
		choices = {
			0: {
				choice_text = null,
				response_text = null,
			},
			1: {
				choice_text = null,
				response_text = null,
			},
		},
		choice_index = -1
	},
}
