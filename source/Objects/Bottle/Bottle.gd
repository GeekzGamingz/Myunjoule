extends StaticBody2D
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
onready var player = get_parent().get_node("Player")
#-------------------------------------------------------------------------------------------------#
#Process
func _process(delta: float) -> void:
	#Testing for functionality. Find better play to call function.
	if inRange:
		start_flavor()
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	pass
#Let the dialog know to show the next dialog, closes when done
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("activate") and inDialogue:
		call_deferred("emit_signal", "next_dialog")
	elif (Input.is_action_just_pressed("activate") and
		player.talking.is_talking and inRange):
		start_dialog()
#-------------------------------------------------------------------------------------------------#
#Dialogue Entered
func _on_DialogArea_body_entered(body: Node) -> void:
	if body.name == "Player":
		inRange = true
#Dialogue Exited
func _on_DialogArea_body_exited(body: Node) -> void:
	if body.name == "Player":
		inRange = false
#-------------------------------------------------------------------------------------------------#
#Dialogue Handler
#Checks for Dialogue
func diaCheck():
	set_deferred("inDialogue", "true")
	player.talking.is_talking = true
	dialog = dialog_scene.instance()
	dialog.connect("diaDone", self, "handleDiaDone")
	var _load_dialog = connect("next_dialog", dialog, "load_dialog")
#Checks for Flavor
func flavCheck():
	dialog = dialog_scene.instance()
	dialog.connect("diaDone", self, "handleDiaDone")
	var _load_dialog = connect("next_dialog", dialog, "load_dialog")
#Finishes Dialogue
func handleDiaDone():
	phaseDia += 1
	inDialogue = false
	player.talking.is_talking = false
	inRange = true
#-------------------------------------------------------------------------------------------------#
#Adds Dialog Child
func addDia():
	get_parent().get_node("UI").call_deferred("add_child", dialog)
#-------------------------------------------------------------------------------------------------#
#Starts Dialog
func start_dialog() -> void:
	if !inDialogue:
		match(phaseDia):
			0:
				diaCheck()
				dialog.dialog = Dialogue.Bottle
				addDia()
			1:
				diaCheck()
				dialog.dialog = Dialogue.BottleBattery
				addDia()
				player.chargeEnergy(100)
#-------------------------------------------------------------------------------------------------#
#Starts Flavor
func start_flavor() -> void:
	match(phaseDia):
		0:
			print("test")
			flavCheck()
			dialog.dialog = Dialogue.BottleFlav
			addDia()
