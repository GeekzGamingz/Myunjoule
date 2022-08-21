extends POI
class_name Bottle

func activate() -> void:
	print("Activating from bottle")
	get_parent().next_dialog()
