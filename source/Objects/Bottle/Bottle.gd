extends StaticBody2D
#-------------------------------------------------------------------------------------------------#
#Variables
var dialog_scene = preload("res://source/UI/Dialog/DialogInterface.tscn")
var level = "Debug_Zeuk"
#-------------------------------------------------------------------------------------------------#
func _on_DialogArea_body_entered(body: Node) -> void:
	if body.name == "Player":
		var dialog = dialog_scene.instance()
		dialog.dialog = ['[color=black]“It\'s a secret to everyone...”']
		get_parent().get_node("Player").call_deferred("add_child", dialog)
