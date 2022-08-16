extends StaticBody2D
var startDialogue = false
var inDialogue = false
var inRange = false
#-------------------------------------------------------------------------------------------------#
#Variables
var dialog_scene = preload("res://source/UI/Dialog/DialogInterface.tscn")
#-------------------------------------------------------------------------------------------------#
func _process(delta: float) -> void:
	if startDialogue && !inDialogue:
		inDialogue = true
		startDialogue = false
		var dialog = dialog_scene.instance()
		dialog.connect("diaDone", self, "handleDiaDone")
		dialog.dialog = ['[color=black]“It\'s a secret to everyone...”']
		get_parent().get_node("Player").call_deferred("add_child", dialog)
#Toggle startDialogue
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("activate") && inRange:
		inRange = false
		startDialogue = true
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
