extends Node

onready var dialogText: RichTextLabel = $Dialogue/MarginContainer/DialogText
onready var choice1: RichTextLabel = $Choice1/MarginContainer/DialogText
onready var choice2: RichTextLabel = $Choice2/MarginContainer/DialogText
onready var choice1Label: RichTextLabel = $Choice1/MarginContainer2/DialogText2
onready var choice2Label: RichTextLabel = $Choice2/MarginContainer2/DialogText2
onready var choice1Label_rect = choice1Label.get_rect()
onready var choice2Label_rect = choice2Label.get_rect()
onready var textTween = $Dialogue/MarginContainer/TextTween
onready var total_phases = dialog.keys().size()
var current_phase = 0
var dialog_index = 0
var finished = false
var making_choice = false
var reset = false

signal dialog_finished
signal dialog_phase_done(phase_completed)

#export(res_Dialogue) var dialog
export(Resource) var resource
var dialog = {
	0: {
		required_flag = null,
		start_flag = null,
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

func _ready() -> void:
	load_dialog()
	$Choice1.visible = false
	$Choice2.visible = false
	var _tween_finished = $Dialogue/MarginContainer/TextTween.connect("tween_completed", self, "_on_TextTween_tween_completed")

func _input(_event: InputEvent) -> void:
#	if Input.is_action_just_pressed("activate") and finished:
#		load_dialog()
#
#	if Input.is_action_just_pressed("expo_tab"):
#		print("Making choice? ", making_choice)
	
	if making_choice and dialog[current_phase].choice_index == dialog_index:
		if Input.is_action_just_pressed("select_choice_1"):
			pick_choice(1)
		if Input.is_action_just_pressed("select_choice_2"):
			pick_choice(2)

func check_requirements() -> bool:
	if dialog[current_phase].required_flag != null:
		return Globals.flags[dialog[current_phase].required_flag] == true
	else:
		return true

func load_dialog(dialog_text: String = ''):
	if current_phase >= total_phases:
		emit_signal("dialog_finished")
		queue_free()
		return
	
	if (not making_choice and dialog_index < dialog[current_phase].dialogue.size()) or dialog_text != '':
		finished = false
		if dialog_text != '':
			dialogText.bbcode_text = dialog_text
		else:
			dialogText.bbcode_text = dialog[current_phase].dialogue[dialog_index]
		
		if dialog[current_phase].choice_index == dialog_index:
			making_choice = true
			load_choice1()
			load_choice2()
		
		dialogText.percent_visible = 0
		textTween.interpolate_property(dialogText, "percent_visible",
			0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		textTween.start()
	
	if dialog_index >= dialog[current_phase].dialogue.size():
		emit_signal("dialog_phase_done", current_phase)
		dialog_index = 0
		reset = true
		
		if dialog[current_phase].start_flag != null and Globals.flags[dialog[current_phase].start_flag] == null:
			Globals.flags[dialog[current_phase].start_flag] = false
		
		if current_phase < total_phases:
			current_phase += 1
	
	if dialog_text == '' and not making_choice and not reset:
		var before = dialog_index
		dialog_index += 1
	elif reset:
		reset = false

func load_choice1():
	$Choice1.visible = true
	finished = false
	choice1.bbcode_text = dialog[current_phase].choices[0].choice_text
	choice1.percent_visible = 0
	textTween.interpolate_property(choice1, "percent_visible",
		0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	textTween.start()

func load_choice2():
	$Choice2.visible = true
	finished = false
	choice2.bbcode_text = dialog[current_phase].choices[1].choice_text
	choice2.percent_visible = 0
	textTween.interpolate_property(choice2, "percent_visible",
		0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	textTween.start()

func pick_choice(choice_number: int):
	dialog_index += 1
	$Choice1.visible = false
	$Choice2.visible = false
	if choice_number == 1:
		load_dialog(dialog[current_phase].choices[0].response_text)
	if choice_number == 2:
		load_dialog(dialog[current_phase].choices[1].response_text)
	making_choice = false

func _on_TextTween_tween_completed(_object: Object, _key: NodePath) -> void:
	finished = true
