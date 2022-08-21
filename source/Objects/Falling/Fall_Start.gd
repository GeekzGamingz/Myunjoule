extends Area2D

export var story = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self, "start_falling")

func start_falling(body: Node) -> void:
	if body.has_method("set_is_falling") and body.story == story:
		body.set_is_falling(true)
