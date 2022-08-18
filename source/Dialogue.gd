extends Node
#-------------------------------------------------------------------------------------------------#
#Objects
#Bottle
var Bottle = {
	dialogue = [
		"[color=black]It's a secret to everyone..."
	],
	choice_index = -1
}
var BottleBattery = {
	dialogue = [
		"[color=black]What's this? There are spare [color=green][wave]batteries[/wave][color=black] in here!"
	],
	choice_index = -1
}
var BottleFlav = {
	dialogue = [
		"[color=black]A strange bottle buried in the sand..."
	],
	choice_index = -1
}
#-------------------------------------------------------------------------------------------------#
#Yorker
#var YorkerIntro = [
#	'[color=black]Yorker\n[color=red]“...Hey! Are you even listenin\' to me?”',
#	'[color=black]Yorker\n[color=red]“Yeah, you! I\'m talking to you! Come over here, would ya?”',
#]
var YorkerIntro = {
	dialogue = [
		'[color=black]Yorker\n[color=red]“...Hey! Are you even listenin\' to me?”',
		'[color=black]Yorker\n[color=red]“Yeah, you! I\'m talking to you! Come over here, would ya?”',
	],
	choice_index = -1
}

var YorkerChoiceDia1 = {
	dialogue = [
		'[color=black]Yorker\n[color=red]“Agh, this is why I hate sand! It gets everywhere, even in my joints! What a nuisance, eh?”',
		'[color=black]Yorker\n[color=red]“...Woah, why\'re you lookin\' at me like that? You short circuiting, or somethin\'?”',
		'[color=black]Yorker\n[color=red]"Ah, whatever."',
		'[color=black]Yorker\n[color=red]“You\'re a repair drone, right? Look, can you fix me up? Been difficult to get around anywhere. Legs just aren\'t quite what they used to be, ya know?”',
		'[color=black]Yorker\n[color=red]“Feels like everything\'s gettin\' so [shake level=2]rusty[/shake].”',
	],
	choice_index = 1,
}
var YorkerChoice1 = {
	choice_text = '[color=blue][center]“Sorry, I must have been daydreaming.”',
	response_text = '[color=black]Yorker\n[color=red]“What the heck? \'Daydreaming?\' Pal, you must be broken somewhere. Machines don\'t dream.”'
}
var YorkerChoice2 = {
	choice_text = '[color=blue][center]“What do you want?”',
	response_text = '[color=black]Yorker\n[color=red]“Oh, I guess I don\'t exactly belong right here, either, huh.”'
}

var YorkerFixedUp = {
	dialogue = [
		'[color=black]Yorker\n[color=red]“Well, would you look at that? Almost good as new!”',
		'[color=black]Yorker\n[color=red]“Hey, you\'re pretty good at this. Thanks for the help, yeah?”',
		'[color=black]Yorker\n[color=red]“Name\'s YORKER. Some folks mentioned spotting a repair drone from the old [LUNAR project] hangin\' around the beachside, and anyone else that claims to know their way around power tools wants to charge ya an arm and a leg. Sometimes even literally.”',
		'[color=black]Yorker\n[color=red]“I bet some others in town could use some fine tuning, too. You look as if ya need to get out more, anyway. And is [shake level=7]THAT[/shake] your recharge home?”',
	],
	choice_index = -1,
}

var YorkerCleans = {
	dialogue = [
		'[color=black]Yorker\n[color=red]“Egads, this thing\'s a rust bucket! Pal, how long have you even been out here?”',
		'[color=black]Yorker\n[color=red]“Well, I guess it doesn\'t matter. Tell you what...”',
		'[color=black]Yorker\n[color=red]“You go off and stretch your treads a bit, I\'ll polish up your house in a jiffy.”',
		'[color=black]Yorker\n[color=red]“If ya don\'t know where to stretch, I spotted something shiny out in the sand on my way here. Looked like a glass bottle. Too many bots just littering away, nowadays! What has this world come to, huh?”',
		'[color=black]Yorker\n[color=red]“Off with you, then! I\'ll have this thing spotless before you can track any more sand in.”',
	],
	choice_index = -1
}
#-------------------------------------------------------------------------------------------------#
