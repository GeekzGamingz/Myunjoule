extends Area2D

var flavor = {
	dialogue = ['Yorker looks like they want to talk to you.'],
	choice_index = -1,
}

func activate() -> void:
	get_parent().start_dialog()
