extends StaticBody2D

func _process(delta: float) -> void:
	if Globals.flags.myunjoule == false:
		queue_free()
