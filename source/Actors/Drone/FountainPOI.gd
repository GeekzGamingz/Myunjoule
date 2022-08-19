extends Area2D

var flavor = {
	dialogue = ['"Fountain"'],
	choice_index = -1,
}

func activate() -> void:
	get_parent().start_dialog()
