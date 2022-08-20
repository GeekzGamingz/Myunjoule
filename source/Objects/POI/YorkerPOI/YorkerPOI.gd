extends POI

func activate() -> void:
	if Globals.flags.fixed_yorker == false:
		Globals.flags.fixed_yorker = true
	else:
		get_parent().next_dialog()
