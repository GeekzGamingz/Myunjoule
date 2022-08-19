extends KinematicBody2D
#-------------------------------------------------------------------------------------------------#
#Variables
var dialog
var inDialogue = false
var inRange = false
var phaseDia = 0
var dialog_scene = preload("res://source/UI/Dialog/DialogInterface.tscn")

# warning-ignore:unused_signal
signal next_dialog

#OnReady Variables
onready var player = get_tree().root.get_node("Moon/YSort/Player")
onready var UI = get_tree().root.get_node("Moon/YSort/UI")
#-------------------------------------------------------------------------------------------------#
func _ready() -> void:
	start_dialog()
#Let the dialog know to show the next dialog, closes when done
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("activate") and inDialogue:
		call_deferred("emit_signal", "next_dialog")
#-------------------------------------------------------------------------------------------------#
#Dialogue Entered
func _on_DialogArea_body_entered(body: Node) -> void:
	if body.name == "Player":
		inRange = true
#Dialogue Exited
func _on_DialogArea_body_exited(body: Node) -> void:
	if body.name == "Player":
		inRange = false
func diaCheck():
	set_deferred("inDialogue", "true")
	player.talking.is_talking = true
	dialog = dialog_scene.instance()
	dialog.connect("diaDone", self, "handleDiaDone")
	var _load_dialog = connect("next_dialog", dialog, "load_dialog")
func addDia():
	UI.call_deferred("add_child", dialog)
func handleDiaDone():
	phaseDia += 1
	inDialogue = false
	player.talking.is_talking = false
	inRange = true
func handle_after_dialog_actions() -> void:
	match(phaseDia):
		3:
			print("Make yorker run to the drop pod")
func check_phase_requirements() -> bool:
	match(phaseDia):
		2:
			return Globals.flags.fixed_yorker
		4:
			return Globals.flags.has_bottle
	return false
func start_dialog() -> void:
	if !inDialogue:
		match(phaseDia):
			0:
				diaCheck()
				dialog.dialog = Dialogue.YorkerIntro
				addDia()
			1:
				diaCheck()
				dialog.dialog = Dialogue.YorkerChoiceDia1
				dialog.diaChoice1 = Dialogue.YorkerChoice1
				dialog.diaChoice2 = Dialogue.YorkerChoice2
				addDia()
			2:
				if check_phase_requirements():
					diaCheck()
					dialog.dialog = Dialogue.YorkerFixedUp
					addDia()
			3:
				diaCheck()
				dialog.dialog = Dialogue.YorkerCleans
				addDia()
			4:
				if check_phase_requirements():
					diaCheck()
					dialog.dialog = Dialogue.YorkerFreesExpo
					addDia()
