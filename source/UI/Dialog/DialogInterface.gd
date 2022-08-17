extends Control
#-------------------------------------------------------------------------------------------------#
#Variables
var dialogIndex = 0
#Bool Variables
var finished = false
#OnReady Variables
onready var dialogText = $TextureRect/MarginContainer/DialogText
onready var textTween = $TextureRect/MarginContainer/TextTween
onready var choice1: RichTextLabel = $Choice1/MarginContainer/DialogText
onready var choice2: RichTextLabel = $Choice2/MarginContainer/DialogText
onready var choice1Label: RichTextLabel = $Choice1/MarginContainer2/DialogText2
onready var choice2Label: RichTextLabel = $Choice2/MarginContainer2/DialogText2
onready var choice1Label_rect = choice1Label.get_rect()
onready var choice2Label_rect = choice2Label.get_rect()
#Signals
signal diaDone
#-------------------------------------------------------------------------------------------------#
#Dialog
var dialog = [
	'[color=black]This is a test of the BB Code format.\nI can fit a total of 6 lines of dialog and have it all\nlook nice and neat and centered and such.\nPretty nifty...\nDon\'t you think?\nWell, I do.',
	'[color=black]I am attempting to code my own dialog box so that I don\'t need to unravel other programmers\' codes and implement my own system!!',
	'[color=black]There are several advantages to BB Code such as animated text like...',
	'[color=black]A [wave]wave[/wave] effect!,\nI can also change the [wave amp=100]amplitude[/wave] or the [wave freq=10]frequency[/wave].',
	'[color=black]The next effect is the [tornado]tornado[/tornado] effect.\nWith this I can affect the [tornado radius=20]radius[/tornado] as well as the [tornado freq=10]frequency[/tornado].',
	'[color=black]Now we move onto the [shake level=10]shake[/shake] effect.\nThis will be useful to emphasis [shake level=10]fear[/shake] in a dialog.\nI can control not only the [shake level=10 rate=5000]rate[/shake], but the [shake level=50]level[/shake] as well.',
	'[color=black]Moving on, we have [fade start=0 length=4]fade[/fade].\nYou can [fade start=0 length=5]start[/fade] with one word or use an entire phrase.\n\"[shake level=10]Mr. Stark[/shake]... [wave][fade start=0 length=20]I don\'t feel so good[/fade][/wave]\".',
	'[color=black]And the last effect is the [color=white][rainbow]rainbow[/rainbow][color=black].\nThis is great for showing people how [color=white][rainbow]GAAAAAAY[/rainbow][color=black] you are!\nYou can change the [color=white][rainbow sat=0.5]saturation[/rainbow][color=black] and [color=white][rainbow freq=5]frequency[/rainbow][color=black].'
]
var diaChoice1 = ['']
var diaChoice2 = ['']
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	print("Running ready")
	load_dialog()
	load_choice1()
	load_choice2()
#	$Choice1.visible = false
#	$Choice2.visible = false
#-------------------------------------------------------------------------------------------------#
#Load Dialog
func load_dialog():
	if dialogIndex < dialog.size():
		finished = false
		print("Loading dialog text")
		dialogText.bbcode_text = dialog[dialogIndex]
		dialogText.percent_visible = 0
		textTween.interpolate_property(dialogText, "percent_visible",
			0, 1, 1.5, Tween.TRANS_LINEAR,Tween. EASE_IN_OUT)
		textTween.start()
	else:
		emit_signal("diaDone")
		print("Queue freeing...")
		queue_free()
	dialogIndex += 1
func load_choice1():
	if diaChoice1 != ['']:
		$Choice1.visible = true
		finished = false
		choice1.bbcode_text = diaChoice1[0]
		choice1.percent_visible = 0
		textTween.interpolate_property(choice1, "percent_visible",
			0, 1, 1.5, Tween.TRANS_LINEAR,Tween. EASE_IN_OUT)
		textTween.start()
	else:
		$Choice1.visible = false
func load_choice2():
	if diaChoice1 != ['']:
		$Choice2.visible = true
		finished = false
		choice2.bbcode_text = diaChoice2[0]
		choice2.percent_visible = 0
		textTween.interpolate_property(choice2, "percent_visible",
			0, 1, 1.5, Tween.TRANS_LINEAR,Tween. EASE_IN_OUT)
		textTween.start()
	else:
		$Choice2.visible = false
#Next/Finish Dialog
func _on_TextTween_tween_completed(object: Object, key: NodePath) -> void:
	finished = true
#-------------------------------------------------------------------------------------------------#
