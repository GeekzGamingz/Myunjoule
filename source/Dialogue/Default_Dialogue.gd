extends Resource

var dialog = {
	0: {
		required_flag = '',
		start_flag = '',
		dialogue = [
			'[color=black]This is a test of the BB Code format.\nI can fit a total of 6 lines of dialog and have it all\nlook nice and neat and centered and such.\nPretty nifty...\nDon\'t you think?\nWell, I do.',
			'[color=black]I am attempting to code my own dialog box so that I don\'t need to unravel other programmers\' codes and implement my own system!!',
			'[color=black]There are several advantages to BB Code such as animated text like...',
			'[color=black]A [wave]wave[/wave] effect!,\nI can also change the [wave amp=100]amplitude[/wave] or the [wave freq=10]frequency[/wave].',
			'[color=black]And this is what a choice looks like. Hit the 1 or 2 keys to pick.',
			'[color=black]The next effect is the [tornado]tornado[/tornado] effect.\nWith this I can affect the [tornado radius=20]radius[/tornado] as well as the [tornado freq=10]frequency[/tornado].',
			'[color=black]Now we move onto the [shake level=10]shake[/shake] effect.\nThis will be useful to emphasis [shake level=10]fear[/shake] in a dialog.\nI can control not only the [shake level=10 rate=5000]rate[/shake], but the [shake level=50]level[/shake] as well.',
			'[color=black]Moving on, we have [fade start=0 length=4]fade[/fade].\nYou can [fade start=0 length=5]start[/fade] with one word or use an entire phrase.\n\"[shake level=10]Mr. Stark[/shake]... [wave][fade start=0 length=20]I don\'t feel so good[/fade][/wave]\".',
			'[color=black]And the last effect is the [color=white][rainbow]rainbow[/rainbow][color=black].\nThis is great for showing people how [color=white][rainbow]GAAAAAAY[/rainbow][color=black] you are!\nYou can change the [color=white][rainbow sat=0.5]saturation[/rainbow][color=black] and [color=white][rainbow freq=5]frequency[/rainbow][color=black].'
		],
		choices = {
			0: {
				choice_text = 'Choice #1',
				response_text = 'Response to choice 1',
			},
			1: {
				choice_text = 'Choice #2',
				response_text = 'Response to choice 2',
			},
		},
		choice_index = 4
	}
}
