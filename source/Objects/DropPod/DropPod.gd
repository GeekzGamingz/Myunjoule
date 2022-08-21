extends StaticBody2D
onready var player = get_tree().root.get_node("Moon/YSort/Player")

func _ready() -> void:
	$AnimationPlayer.play("phase_1")

func next_dialog():
	$DialogHandler.next_dialogue()

#Temp
func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		player.is_slep = true
