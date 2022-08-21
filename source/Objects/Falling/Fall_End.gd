extends Area2D

export var story = 0
onready var tile_map = get_tree().root.get_node("Moon/TileMap")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self, "end_falling")

func end_falling(body: Node) -> void:
	if body.has_method("set_is_falling") and body.story == story:
		body.set_is_falling(false)
		match(story):
			0:
				var second_story_collisions = get_tree().get_nodes_in_group("second_story")
				for collision in second_story_collisions:
					collision.set_deferred("disabled", true)
				
				tile_map.set_collision_layer_bit(0, true)
