extends POI

func activate() -> void:
	if Globals.flags.fixed_yorker == false:
		Globals.flags.fixed_yorker = true
	if Globals.flags.expo_tutorial == false:
		Globals.flags.expo_tutorial = true
	else:
		get_parent().next_dialog()
