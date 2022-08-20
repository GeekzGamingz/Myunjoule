extends Resource

var dialog = {
	0: {
		required_flag = null,
		start_flag = null,
		dialogue = [
			'[color=black]Yorker\n[color=red]“...Hey! Are you even listenin\' to me?”',
			'[color=black]Yorker\n[color=red]“Yeah, you! I\'m talking to you! Come over here, would ya?”',
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
	1: {
		required_flag = null,
		start_flag = "fixed_yorker",
		dialogue = [
			'[color=black]Yorker\n[color=red]“Agh, this is why I hate sand! It gets everywhere, even in my joints! What a nuisance, eh?”',
			'[color=black]Yorker\n[color=red]“...Woah, why\'re you lookin\' at me like that? You short circuiting, or somethin\'?”',
			'[color=black]Yorker\n[color=red]"Ah, whatever."',
			'[color=black]Yorker\n[color=red]“You\'re a repair drone, right? Look, can you fix me up? Been difficult to get around anywhere. Legs just aren\'t quite what they used to be, ya know?”',
			'[color=black]Yorker\n[color=red]“Feels like everything\'s gettin\' so [shake level=2]rusty[/shake].”',
		],
		choices = {
			0: {
				choice_text = '[color=blue][center]“Sorry, I must have been daydreaming.”',
				response_text = '[color=black]Yorker\n[color=red]“What the heck? \'Daydreaming?\' Pal, you must be broken somewhere. Machines don\'t dream.”',
			},
			1: {
				choice_text = '[color=blue][center]“What do you want?”',
				response_text = '[color=black]Yorker\n[color=red]“Oh, I guess I don\'t exactly belong right here, either, huh.”',
			},
		},
		choice_index = 1
	},
}
