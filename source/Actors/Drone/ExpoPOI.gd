extends Area2D

var flavor = {
	dialogue = ['"A bottle? I wonder what\'s inside"'],
	choice_index = -1,
	start_flag = ''
}

func activate() -> void:
	get_parent().start_dialog()
