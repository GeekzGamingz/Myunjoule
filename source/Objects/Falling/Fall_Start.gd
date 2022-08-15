extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self, "start_falling")

func start_falling(body: Node) -> void:
	if body.has_method("set_is_falling"):
		body.set_is_falling(true)
