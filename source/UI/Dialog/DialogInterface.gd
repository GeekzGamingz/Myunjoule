extends Control
#-------------------------------------------------------------------------------------------------#
#Variables
var dialogIndex = 0
#Bool Variables
var finished = false
#OnReady Variables
onready var dialogText: RichTextLabel = $Dialogue/MarginContainer/DialogText
onready var choice1: RichTextLabel = $Choice1/MarginContainer/DialogText
onready var choice2: RichTextLabel = $Choice2/MarginContainer/DialogText
onready var choice1Label: RichTextLabel = $Choice1/MarginContainer2/DialogText2
onready var choice2Label: RichTextLabel = $Choice2/MarginContainer2/DialogText2
onready var flavor: RichTextLabel = $Flavor/MarginContainer/DialogText
onready var choice1Label_rect = choice1Label.get_rect()
onready var choice2Label_rect = choice2Label.get_rect()
onready var textTween = $Dialogue/MarginContainer/TextTween
#Signals
signal diaDone
#-------------------------------------------------------------------------------------------------#
#Dialog
var dialog = {
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
	choice_index = 4,
}
var blank_choice = {
	choice_text = '',
	response_text = '',
}
var diaChoice1 = {
	choice_text = 'Choice #1',
	response_text = 'Response to choice 1.',
}
var diaChoice2 = {
	choice_text = 'Choice #2',
	response_text = 'Response to choice 2.',
}
var diaFlavor = {
	choice_text = '[center][color=black]Flavor',
	response_text = ''
}
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	load_dialog()
	load_flavor()
	$Choice1.visible = false
	$Choice2.visible = false
#	$Flavor.visible = false
func _input(_event: InputEvent) -> void:
	if dialog.choice_index == dialogIndex - 1:
		if Input.is_action_just_pressed("select_choice_1"):
			pick_choice(1)
		if Input.is_action_just_pressed("select_choice_2"):
			pick_choice(2)
#	if Input.is_action_just_pressed("activate"):
#		load_dialog()
#		load_choice1()
#		load_choice2()
#-------------------------------------------------------------------------------------------------#
#Load Dialog
func load_dialog(dialog_text: String = ''):
	if dialogIndex < dialog.dialogue.size() or dialog_text:
		finished = false
		if dialog_text != '':
			dialogText.bbcode_text = dialog_text
		else:
			dialogText.bbcode_text = dialog.dialogue[dialogIndex]
		if dialog.choice_index == dialogIndex:
			load_choice1()
			load_choice2()
		dialogText.percent_visible = 0
		textTween.interpolate_property(dialogText, "percent_visible",
			0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		textTween.start()
	else:
		emit_signal("diaDone")
		queue_free()
	if dialog_text == '':
		dialogIndex += 1
#Choices
func load_choice1():
	$Choice1.visible = true
	finished = false
	choice1.bbcode_text = diaChoice1.choice_text
	choice1.percent_visible = 0
	textTween.interpolate_property(choice1, "percent_visible",
		0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	textTween.start()
func load_choice2():
	$Choice2.visible = true
	finished = false
	choice2.bbcode_text = diaChoice2.choice_text
	choice2.percent_visible = 0
	textTween.interpolate_property(choice2, "percent_visible",
		0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	textTween.start()
#Flavor
func load_flavor():
	$Flavor.visible = true
	finished = false
	flavor.bbcode_text = diaFlavor.choice_text
	flavor.percent_visible = 0
	textTween.interpolate_property(flavor, "percent_visible",
		0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	textTween.start()
#-------------------------------------------------------------------------------------------------#
#Choice Picker
func pick_choice(choice_number: int):
	set_deferred("diaChoice1", blank_choice)
	set_deferred("diaChoice2", blank_choice)
	$Choice1.visible = false
	$Choice2.visible = false
	if choice_number == 1:
		load_dialog(diaChoice1.response_text)
	if choice_number == 2:
		load_dialog(diaChoice2.response_text)
#-------------------------------------------------------------------------------------------------#
#Next/Finish Dialog
func _on_TextTween_tween_completed(_object: Object, _key: NodePath) -> void:
	finished = true
#-------------------------------------------------------------------------------------------------#
