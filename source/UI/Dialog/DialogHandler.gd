extends Area2D
class_name DialogHandler

export var immediate: bool = false

export(Resource) var dialog_resource

var dialog_scene = preload("res://source/UI/Dialog/DialogInterface.tscn")
var dialog
var in_dialogue = false
var in_range = false

signal next_dialog

onready var player = get_tree().root.get_node("Moon/YSort/Player")
onready var UI = get_tree().root.get_node("Moon/YSort/UI")

func _ready() -> void:
	var _body_entered = connect("body_entered", self, "_on_dialog_area_body_entered")
	var _body_exited = connect("body_exited", self, "_on_dialog_area_body_exited")
	dialog = dialog_scene.instance()
	dialog.dialog = dialog_resource.dialog
	var _next_dialog = connect("next_dialog", dialog, "load_dialog")
	var _dialog_phase_done = dialog.connect("dialog_phase_done", self, "_on_dialog_phase_done")
	dialog.visible = false
	UI.add_child(dialog)
	if immediate:
		next_dialogue()
		immediate = false

#Let the dialog know to show the next dialog, closes when done
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("activate") and in_dialogue:
		call_deferred("emit_signal", "next_dialog")

# Virtual functions
func handle_after_dialog_actions(phase: int) -> void:
	pass

# Functions
func next_dialogue() -> void:
	if in_range or immediate:
		set_deferred("in_dialogue", true)
		dialog.set_deferred("visible", true)
		if not immediate:
			call_deferred("emit_signal", "next_dialog")

# Handlers
func _on_dialog_area_body_entered(body: Node) -> void:
	if body.name == "Player":
		in_range = true

func _on_dialog_area_body_exited(body: Node) -> void:
	if body.name == "Player":
		in_range = false

func _on_dialog_phase_done(finished_phase: int):
	print_debug("Dialog phase done: ", finished_phase)
	dialog.set_deferred("visible", false)
	set_deferred("in_dialogue", false)
	player.talking.is_talking = false
	if not immediate:
		in_range = true
	handle_after_dialog_actions(finished_phase)
