extends KinematicBody2D
#-------------------------------------------------------------------------------------------------#
#Variables
var dialog
var inDialogue = false
var inRange = false
var phaseDia = 0
var dialog_scene = preload("res://source/UI/Dialog/DialogInterface.tscn")
signal next_dialog
#OnReady Variables
#-------------------------------------------------------------------------------------------------#
#Let the dialog know to show the next dialog, closes when done
func _input(event: InputEvent) -> void:
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
	dialog = dialog_scene.instance()
	dialog.connect("diaDone", self, "handleDiaDone")
	connect("next_dialog", dialog, "load_dialog")
func handleDiaDone():
	inDialogue = false
	inRange = true
	phaseDia += 1
func addDia():
	get_parent().get_node("UI").call_deferred("add_child", dialog)
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
