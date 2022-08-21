extends POI

export var story = 1
onready var tile_map = get_tree().root.get_node("Moon/TileMap")

func activate() -> void:
	match(story):
		1:
			var second_story_collisions = get_tree().get_nodes_in_group("second_story")
			for collision in second_story_collisions:
				collision.set_deferred("disabled", false)
			
			tile_map.set_collision_layer_bit(0, false)
