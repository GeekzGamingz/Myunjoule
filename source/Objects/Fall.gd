extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self, "toggle_falling")

func toggle_falling(body: Node) -> void:
	print("Entered fall area")
	if body.has_method("toggle_is_falling"):
		print("Body has method: 'toggle_is_falling'")
		body.toggle_is_falling()
