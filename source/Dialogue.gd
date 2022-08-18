extends Node
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
var YorkerChoiceDia1 = [
	'[color=black]Yorker\n[color=red]“Agh, this is why I hate sand! It gets everywhere, even in my joints! What a nuisance, eh?”',
	'[color=black]Yorker\n[color=red]“...Woah, why\'re you lookin\' at me like that? You short circuiting, or somethin\'?”',
]
var YorkerChoiceDia1_ = {
	dialogue = [
		'[color=black]Yorker\n[color=red]“Agh, this is why I hate sand! It gets everywhere, even in my joints! What a nuisance, eh?”',
		'[color=black]Yorker\n[color=red]“...Woah, why\'re you lookin\' at me like that? You short circuiting, or somethin\'?”',
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
