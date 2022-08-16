extends KinematicBody2D
#-------------------------------------------------------------------------------------------------#
var dialog
var startDialogue = false
var inDialogue = false
var inRange = false
var phaseDia = 0
#-------------------------------------------------------------------------------------------------#
#Variables
var dialog_scene = preload("res://source/UI/Dialog/DialogInterface.tscn")
#-------------------------------------------------------------------------------------------------#
func _process(delta: float) -> void:
	if startDialogue && !inDialogue:
		match(phaseDia):
			0:
				diaCheck()
				dialog.dialog = Dialogue.YorkerIntro
				get_parent().get_node("Player").call_deferred("add_child", dialog)
			1:
				diaCheck()
				dialog.dialog = Dialogue.YorkerChoiceDia1
				dialog.diaChoice1 = Dialogue.YorkerChoice1
				dialog.diaChoice2 = Dialogue.YorkerChoice2
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
func diaCheck():
	inDialogue = true
	startDialogue = false
	dialog = dialog_scene.instance()
	dialog.connect("diaDone", self, "handleDiaDone")
func handleDiaDone():
	inDialogue = false
	inRange = true
	phaseDia += 1
