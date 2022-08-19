extends Area2D
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var camera = get_parent().get_node("MainCamera")
onready var transitions = get_tree().root.get_node("Moon/Transitions")
onready var player = get_tree().root.get_node("Moon/YSort/Player")
#-------------------------------------------------------------------------------------------------#
func _on_GridSnapper_area_entered(area: Area2D) -> void:
	match(area.name):
		"ResetCollisions":
			transitions.get_node("TownToBeach/CollisionShape2D").set_deferred("disabled", false)
			transitions.get_node("BeachToTown/CollisionShape2D").set_deferred("disabled", false)
			player.inTransition = false
		"BeachToTown":
			player.inTransition = true
			camera.limit_left = 720
			camera.limit_right = 2160
			transitions.get_node("TownToBeach/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = true
		"TownToBeach":
			player.inTransition = true
			camera.limit_left = -720
			camera.limit_right = 720
			transitions.get_node("BeachToTown/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = false
