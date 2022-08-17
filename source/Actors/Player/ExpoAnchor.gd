extends Node2D

var anchor_pos = position

func _process(_delta: float) -> void:
	if get_parent().move_dir < 0:
		position = anchor_pos
	if get_parent().move_dir > 0:
		position = Vector2(-anchor_pos.x, anchor_pos.y)
