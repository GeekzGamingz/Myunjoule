extends StaticBody2D
var startDialogue = false
var inDialogue = false
var inRange = false
#-------------------------------------------------------------------------------------------------#
#Variables
var dialog_scene = preload("res://source/UI/Dialog/DialogInterface.tscn")
signal next_dialog
#-------------------------------------------------------------------------------------------------#
#Let the dialog know to show the next dialog, closes when done
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("activate") and inDialogue:
		emit_signal("next_dialog")
#-------------------------------------------------------------------------------------------------#
#Dialogue Entered
func _on_DialogArea_body_entered(body: Node) -> void:
	if body.name == "Player":
		inRange = true
#Dialogue Exited
func _on_DialogArea_body_exited(body: Node) -> void:
	if body.name == "Player":
		inRange = false
func handleDiaDone():
	inDialogue = false
	inRange = true
func start_dialog() -> void:
	if !inDialogue:
		inDialogue = true
		var dialog = dialog_scene.instance()
		dialog.connect("diaDone", self, "handleDiaDone")
		var _load_dialog = connect("next_dialog", dialog, "load_dialog")
		dialog.dialog = {
			dialogue = ['[color=black]“It\'s a secret to everyone...”'],
			choice_index = -1
		}
		get_parent().get_node("UI").call_deferred("add_child", dialog)
