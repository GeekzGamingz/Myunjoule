extends Control

var flavor

onready var flavor_text = $MarginContainer/CenterContainer/RichTextLabel
onready var tween = $MarginContainer/CenterContainer/Tween

func _ready() -> void:
	flavor_text.bbcode_text = flavor
	flavor_text.percent_visible = 0
	tween.interpolate_property(flavor_text, "percent_visible",
		0, 1, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
