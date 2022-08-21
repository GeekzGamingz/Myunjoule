extends Resource

var dialog = {
	0: {
		required_flag = null,
		start_flag = null,
		dialogue = [
			'[color=black]Would you like to recharge until the next moon phase?'
		],
		choices = {
			0: {
				choice_text = 'Choice #1',
				response_text = 'Affirmative.',
			},
			1: {
				choice_text = 'Choice #2',
				response_text = 'Negative.',
			},
		},
		choice_index = 0
	},
}
