extends Node
#-------------------------------------------------------------------------------------------------#
#Objects
#Bottle
var Bottle = {
	dialogue = [
		"[color=black]It's a secret to everyone..."
	],
	choice_index = -1,
	start_flag = '',
}
var BottleBattery = {
	dialogue = [
		"[color=black]What's this? There are spare [color=green][wave]batteries[/wave][color=black] in here!"
	],
	choice_index = -1,
	start_flag = '',
}
#-------------------------------------------------------------------------------------------------#
# Yorker
var Yorker = {
	# This is the dialouge that happens when blah blah
	0: {
		required_flag = '',
		start_flag = 'fixed_yorker',
		dialogue = [
			'[color=black]Yorker\n[color=red]“...Hey! Are you even listenin\' to me?”',
			'[color=black]Yorker\n[color=red]“Yeah, you! I\'m talking to you! Come over here, would ya?”',
		],
		choices = {
			0: {
				choice_text = '',
				response_text = '',
			},
			1: {
				choice_text = '',
				response_text = '',
			},
		},
		choice_index = -1
	},
}

#var YorkerIntro = {
#	dialogue = [
#		'[color=black]Yorker\n[color=red]“...Hey! Are you even listenin\' to me?”',
#		'[color=black]Yorker\n[color=red]“Yeah, you! I\'m talking to you! Come over here, would ya?”',
#	],
#	choice_index = -1,
#	start_flag = '',
#}

#var YorkerChoiceDia1 = {
#	dialogue = [
#		'[color=black]Yorker\n[color=red]“Agh, this is why I hate sand! It gets everywhere, even in my joints! What a nuisance, eh?”',
#		'[color=black]Yorker\n[color=red]“...Woah, why\'re you lookin\' at me like that? You short circuiting, or somethin\'?”',
#		'[color=black]Yorker\n[color=red]"Ah, whatever."',
#		'[color=black]Yorker\n[color=red]“You\'re a repair drone, right? Look, can you fix me up? Been difficult to get around anywhere. Legs just aren\'t quite what they used to be, ya know?”',
#		'[color=black]Yorker\n[color=red]“Feels like everything\'s gettin\' so [shake level=2]rusty[/shake].”',
#	],
#	choice_index = 1,
#	start_flag = 'fixed_yorker'
#}
#var YorkerChoice1 = {
#	choice_text = '[color=blue][center]“Sorry, I must have been daydreaming.”',
#	response_text = '[color=black]Yorker\n[color=red]“What the heck? \'Daydreaming?\' Pal, you must be broken somewhere. Machines don\'t dream.”'
#}
#var YorkerChoice2 = {
#	choice_text = '[color=blue][center]“What do you want?”',
#	response_text = '[color=black]Yorker\n[color=red]“Oh, I guess I don\'t exactly belong right here, either, huh.”'
#}

var YorkerFixedUp = {
	dialogue = [
		'[color=black]Yorker\n[color=red]“Well, would you look at that? Almost good as new!”',
		'[color=black]Yorker\n[color=red]“Hey, you\'re pretty good at this. Thanks for the help, yeah?”',
		'[color=black]Yorker\n[color=red]“Name\'s YORKER. Some folks mentioned spotting a repair drone from the old [LUNAR project] hangin\' around the beachside, and anyone else that claims to know their way around power tools wants to charge ya an arm and a leg. Sometimes even literally.”',
		'[color=black]Yorker\n[color=red]“I bet some others in town could use some fine tuning, too. You look as if ya need to get out more, anyway. And is [shake level=7]THAT[/shake] your recharge home?”',
	],
	choice_index = -1,
	start_flag = ''
}

var YorkerCleans = {
	dialogue = [
		'[color=black]Yorker\n[color=red]“E[shake level=7]gads[/shake], this thing\'s a rust bucket! Pal, how long have you even been out here?”',
		'[color=black]Yorker\n[color=red]“Well, I guess it doesn\'t matter. Tell you what...”',
		'[color=black]Yorker\n[color=red]“You go off and stretch your treads a bit, I\'ll polish up your house in a jiffy.”',
		'[color=black]Yorker\n[color=red]“If ya don\'t know where to stretch, I spotted something shiny out in the sand on my way here. Looked like a glass bottle. Too many bots just littering away, nowadays! What has this world come to, huh?”',
		'[color=black]Yorker\n[color=red]“Off with you, then! I\'ll have this thing spotless before you can track any more sand in.”',
	],
	choice_index = -1,
	start_flag = 'has_bottle'
}

var YorkerFreesExpo = {
	dialogue = [
		'[color=black]Yorker\n[color=red]"Ta-da! Good as new! Whaddaya think, huh?"',
		'[color=black]Yorker\n[color=red]"Oh, you found the bottle. Hm? There’s something in there... some kinda bot. It’s got something etched into its plating... ‘EXPO’?"',
		'[color=black]Yorker\n[color=red]"Woah, that’s odd. It’s suddenly glowing."',
		'[color=black]YORKER fumbles a bit, but manages to uncork the bottle.',
		'[color=black]Expo\n[color=#a64d79]"bee-beep...beewoop?"',
		'[color=black]Yorker\n[color=red]"Would ya look at that? Now THAT’s a throwback if I’ve ever seen one."',
		'[color=black]Yorker\n[color=red]"This is an old X-P0 model Alert Drone— and in great condition, to boot!"',
		'[color=black]Yorker\n[color=red]"Used a long time ago to point out interesting things that the human eye might easily miss. ‘Course, there aren’t anymore humans around, so I’m not sure what use this little guy’s got anymore..."',
		'[color=black]Yorker\n[color=red]"EXPO must be a nickname from whoever took care of it before, if my AI calculation is to be trusted at all."',
		'[color=black]Expo\n[color=#a64d79]"beep-beep! boweep!"',
		'[color=black]Yorker\n[color=red]"Ha, seems it’s taken a liking to ya! If you venture out to [TOWN NAME], maybe the little guy can help ya get around."',
		'[color=black]Expo\n[color=#a64d79]"beewoop!"',
		'[color=black]Yorker\n[color=red]"Since EXPO seems to agree, why don’t you give ‘em a test run? Stand near anything interesting— like me, for example. I’m interestin’ enough, eh?"',
		'[color=black]Yorker\n[color=red]"It should hover nearby and let ya know you can talk to me by using [ACTION]."',
	],
	choice_index = -1,
	start_flag = ''
}

#-------------------------------------------------------------------------------------------------#
