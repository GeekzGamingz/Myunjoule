extends Area2D

var flavor = {
	dialogue = ['"A bottle? I wonder what\'s inside"'],
	choice_index = -1,
}

func activate() -> void:
	get_parent().start_dialog()
