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
			transitions.get_node("TownToLab/CollisionShape2D").set_deferred("disabled", false)
			transitions.get_node("LabToTown/CollisionShape2D").set_deferred("disabled", false)
			transitions.get_node("ForestToBeach/CollisionShape2D").set_deferred("disabled", false)
			transitions.get_node("BeachToForest/CollisionShape2D").set_deferred("disabled", false)
			transitions.get_node("LabToForest/CollisionShape2D").set_deferred("disabled", false)
			transitions.get_node("ForestToLab/CollisionShape2D").set_deferred("disabled", false)
			player.inTransition = false
		#To Beach
		"ForestToBeach":
			player.inTransition = true
			camera.limit_left = -720
			camera.limit_right = 720
			transitions.get_node("BeachToForest/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = false
		"TownToBeach":
			player.inTransition = true
			camera.limit_left = -720
			camera.limit_right = 720
			transitions.get_node("BeachToTown/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = false
		#To Town
		"BeachToTown":
			player.inTransition = true
			camera.limit_left = 720
			camera.limit_right = 2160
			transitions.get_node("TownToBeach/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = true
		"LabToTown":
			player.inTransition = true
			camera.limit_left = -720
			camera.limit_right = 2160
			transitions.get_node("TownToLab/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = true
		#To Lab
		"TownToLab":
			player.inTransition = true
			camera.limit_left = 2160
			camera.limit_right = 3600
			transitions.get_node("LabToTown/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = false
		"ForestToLab":
			player.inTransition = true
			camera.limit_left = 2160
			camera.limit_right = 3600
			player.global_position.x = 3600
			transitions.get_node("LabToForest/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = false
		#To Forest
		"LabToForest":
			player.inTransition = true
			camera.limit_left = -2160
			camera.limit_right = -720
			player.global_position.x = -2160
			transitions.get_node("ForestToLab/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = false
		"BeachToForest":
			player.inTransition = true
			camera.limit_left = -2160
			camera.limit_right = -720
			transitions.get_node("ForestToBeach/CollisionShape2D").set_deferred("disabled", true)
			get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer3").visible = false
