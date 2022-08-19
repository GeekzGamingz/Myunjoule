extends POI

func _ready() -> void:
	flavor.dialogue = ['[color=black]Yorker looks like they want to talk to you.']

func activate() -> void:
	if Globals.flags.fixed_yorker == false:
		Globals.flags.fixed_yorker = true
	else:
		get_parent().start_dialog()
