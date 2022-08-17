extends Area2D

func activate() -> void:
	print("Expo starting dialog")
	get_parent().start_dialog()
