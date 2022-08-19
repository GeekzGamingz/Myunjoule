extends Area2D

var interested = true

var flavor = {
	dialogue = ['Yorker looks like they want to talk to you.'],
	choice_index = -1,
	start_flag = ''
}

func activate() -> void:
	if Globals.flags.fixed_yorker == false:
		Globals.flags.fixed_yorker = true
	else:
		get_parent().start_dialog()
