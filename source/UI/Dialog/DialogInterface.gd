extends Control
#-------------------------------------------------------------------------------------------------#
#Variables
var dialogIndex = 0
#Bool Variables
var finished = false
#OnReady Variables
onready var dialogText = $TextureRect/MarginContainer/DialogText
onready var textTween = $TextureRect/MarginContainer/TextTween
#-------------------------------------------------------------------------------------------------#
#Dialog
var dialog = [
	'[color=black]This is a test of the BB Code format.\nI can fit a total of 4 lines of dialog and have it all look nice and neat and centered and such.\nPretty nifty... Don\'t you think?',
	'[color=black]I am attempting to code my own dialog box so that I don\'t need to unravel other programmers\' codes and implement my own system!!',
	'[color=black]There are several advantages to BB Code such as animated text like...',
	'[color=black]A [wave]wave[/wave] effect!,\nI can also change the [wave amp=100]amplitude[/wave] or the [wave freq=10]frequency[/wave].',
	'[color=black]The next effect is the [tornado]tornado[/tornado] effect.\nWith this I can affect the [tornado radius=20]radius[/tornado] as well as the [tornado freq=10]frequency[/tornado].',
	'[color=black]Now we move onto the [shake level=10]shake[/shake] effect.\nThis will be useful to emphasis [shake level=10]fear[/shake] in a dialog.\nI can control not only the [shake level=10 rate=5000]rate[/shake], but the [shake level=50]level[/shake] as well.',
	'[color=black]Moving on, we have [fade start=0 length=4]fade[/fade].\nYou can [fade start=0 length=5]start[/fade] with one word or use an entire phrase.\n\"[shake level=10]Mr. Stark[/shake]... [wave][fade start=0 length=20]I don\'t feel so good[/fade][/wave]\".',
	'[color=black]And the last effect is the [color=white][rainbow]rainbow[/rainbow][color=black].\nThis is great for showing people how [color=white][rainbow]GAAAAAAY[/rainbow][color=black] you are!\nYou can change the [color=white][rainbow sat=0.5]saturation[/rainbow][color=black] and [color=white][rainbow freq=5]frequency[/rainbow][color=black].'
]
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	load_dialog()
#-------------------------------------------------------------------------------------------------#
#Process
func _process(delta: float) -> void:
	#DialogNextIndicator.visible = finished
	if Input.is_action_just_pressed("activate"):
		load_dialog()
#-------------------------------------------------------------------------------------------------#
#Load Dialog
func load_dialog():
	if dialogIndex < dialog.size():
		finished = false
		dialogText.bbcode_text = dialog[dialogIndex]
		dialogText.percent_visible = 0
		textTween.interpolate_property(dialogText, "percent_visible",
			0, 1, 1.5, Tween.TRANS_LINEAR,Tween. EASE_IN_OUT)
		textTween.start()
	else:
		queue_free()
	dialogIndex += 1
#Next/Finish Dialog
func _on_TextTween_tween_completed(object: Object, key: NodePath) -> void:
	finished = true
