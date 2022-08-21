extends Resource

var dialog = {
	# As a potential polish, perhaps we could hear the sounds of waves crashing before the scene fades in with a bit of narration text?
	0: {
		required_flag = null,
		start_flag = null,
		dialogue = [
			'[color=black]YORKER\n[color=red]"....Hey! Are you even listenin\' to me?"',
			'[color=black]YORKER\n[color=red]"Yeah, you! I\'m talking to you! Come over here, would ya?"',
			'[color=black]YORKER\n[color=red]"Press that ACTION button to talk to me!"',
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
		# if the "fixing" mechanic is added, have this start flag be something to 
		# allow the PLAYER to do so, which would then start the "fixed_yorker" flag.
		dialogue = [
			'[color=black]YORKER\n[color=red]"Agh, this is why I hate sand! It gets everywhere, even in my joints! What a nuisance, eh?"',
			'[color=black]YORKER\n[color=red]"...Woah, why\'re you lookin\' at me like that? You short circuiting, or somethin\'?"',
			'[color=black]YORKER\n[color=red]"Ah, whatever."',
			'[color=black]YORKER\n[color=red]"You\'re a repair drone, right? Look, can you fix me up? Been difficult to get around anywhere."',
			'[color=black]YORKER\n[color=red]"Legs just aren\'t quite what they used to be, ya know?"',
			'[color=black]YORKER\n[color=red]"Feels like everything\'s gettin\' so [b][shake rate=2 level=2]rusty[/b][/shake]."',
		],
		choices = {
			0: {
				choice_text = '[color=blue][center]"sorry, I must have been daydreaming."',
				response_text = '[color=black]YORKER\n[color=red]"What the heck? \'Daydreaming?\' Pal, you [b]must[/b] be broken somewhere. Machines don\'t dream."',
			},
			1: {
				choice_text = '[color=blue][center]"what do you want?"',
				response_text = '[color=black]YORKER\n[color=red]"Oh, I guess I don\'t exactly belong right here, either, huh."',
			},
		},
		choice_index = 1
	},
	
	
	# potential dialogue to repeat if YORKER is spoken to before having been fixed?
#	{
#		required_flag = null,
#		start_flag = null,
#		dialogue = [
#			'[color=black]YORKER\n[color=red]"What\'re you doing, huh? Just press ACTION ta do your repair thing!"',
#		],
#	choices = {
#		0: {
#				choice_text = null,
#				response_text = null,
#			},
#			1: {
#				choice_text = null,
#				response_text = null,
#			},
#			choice_index = -1
#	},
#	},
	
	
	2: {
		# requires PLAYER to have fixed YORKER; finishing this dialogue starts the flag to find the bottle containing EXPO.
		required_flag = "fixed_yorker",
		start_flag = "mystery_bottle",
		dialogue = [
			'[color=black]YORKER\n[color=red]"Well, would you look at that? Almost good as new!"',
			'[color=black]YORKER\n[color=red]"Hey, you\'re pretty good at this. Thanks for the help, yeah?"',
			'[color=black]YORKER\n[color=red]"Name\'s YORKER. Some folks mentioned spotting a repair drone from the old [LUNAR project] hangin\' around the beachside."',
			'[color=black]YORKER\n[color=red]"Anyone else that claims to know their way around power tools wants to charge ya an arm and a leg. Sometimes even literally."',
			'[color=black]YORKER\n[color=red]"I bet some others in town could use some fine tuning, too. You look as if ya need to get out more, anyway. And is [b]THAT[/b] your recharge home?"',
		# YORKER should move over to the recharge station. not sure if a "cutscene" type situation could happen here, 
		# and the PLAYER moves on their own as well, before dialogue starts up again automatically?
			'[color=black]YORKER\n[color=red]"E[b]gads,[/b] this thing\'s a rust bucket! Pal, how long have you even been out here?"',
			'[color=black]YORKER\n[color=red]"Well, I guess it doesn\'t matter. Tell you what..."',
			'[color=black]YORKER\n[color=red]"You go off and stretch your treads a bit, I\'ll polish up your house in a jiffy."',
			'[color=black]YORKER\n[color=red]"If ya don\'t know where to stretch, I spotted something shiny out in the sand on my way here. Looked like a glass bottle."', 
			'[color=black]YORKER\n[color=red]"Too many bots just littering away, nowadays! What has this world come to, huh?"',
			'[color=black]YORKER\n[color=red]"Off with you, then! I\'ll have this thing spotless before you can track any more sand in."',
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
	3: {
		# requires PLAYER to have found the bottle that contains EXPO.
		required_flag = "expo_bottle",
		start_flag = "expo_tutorial",
		dialogue = [
			'[color=black]YORKER\n[color=red]"Ta-da! Good as new! Whaddaya think, huh?"',
			'[color=black]YORKER\n[color=red]"Oh, you found the bottle. Hm? There\'s something in there... some kinda bot. It\'s got something etched into its plating... \'EXPO\'?"',
			'[color=black]YORKER\n[color=red]"Woah, that\'s odd. It\'s suddenly glowing."',
			
			'[color=gray]YORKER fumbles a bit, but manages to uncork the bottle.',
			
			# right here is where EXPO pops out of the bottle and can be seen. should still be in a 'cutscene'?
			
			'[color=black]EXPO\n[color=fuchsia]"bee-beep...[wave amp=5 freq=4]beewoop?[/wave]"',
			
			'[color=black]YORKER\n[color=red]"Would ya look at that? Now THAT\'s a throwback if I\'ve ever seen one."',
			'[color=black]YORKER\n[color=red]"This is an old X-P0 model Alert Drone— and in great condition, to boot!"',
			'[color=black]YORKER\n[color=red]"Used a long time ago to point out interesting things that the human eye might easily miss. \'Course, there aren\'t anymore humans around,',
			'[color=black]YORKER\n[color=red]"so I\'m not sure what use this little guy\'s got anymore..."',
			'[color=black]YORKER\n[color=red]"EXPO must be a nickname from whoever took care of it before, if my AI calculation is to be trusted at all."',
			
			# EXPO could potentially float around the PLAYER here, as if excited. if possible, comment out the following dialogue:
			'[color=gray]EXPO floats around you excitedly.',
			
			'[color=black]EXPO\n[color=fuchsia]"beep-beep! boweep!"',
			
			'[color=black]YORKER\n[color=red]"Ha, seems it\'s taken a liking to ya! If you venture out to Myunjoule Village, maybe the little guy can help ya get around."',
			
			'[color=black]EXPO\n[color=fuchsia]"beewoop!"',
			
			'[color=black]YORKER\n[color=red]"Since EXPO seems to agree, why don\'t you give \'em a test run? Stand near anything interesting— like me, for example. I\'m interestin\' enough, eh?"',
			'[color=black]YORKER\n[color=red]"It should hover nearby and let ya know you can talk to me by using the ACTION button."',
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
	#PLAYER should speak to YORKER after EXPO first appears to trigger this dialogue. this dialogue should be the trigger to allow the PLAYER to access the next area.
	4: {
		required_flag = "expo_tutorial",
		start_flag = "myunjoule",
		dialogue = [
			'[color=black]YORKER\n[color=red]"Ey, works like a charm! Should be able to do the same with any objects you come across, too— like your recharge home here."',
			'[color=black]YORKER\n[color=red]"If you see the little guy fly off and light up,  it\'s probably worth to check it out. Can\'t hurt to be just a [b]little[/b] curious, right?"',
			'[color=black]YORKER\n[color=red]"Anyway, I gotta get back to work. This endless sand\'s not gonna clean itself up! [color=gray][shake level=2]Jeez, where do I even start...[/shake][/color]"',
			
			'[color=black]EXPO\n[color=fuchsia]"bo-weep?"',
			
			'[color=gray]EXPO will be following you from now on.',
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
