extends Control
#-------------------------------------------------------------------------------------------------#
#Signals
signal scene_changed()
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var animPlayer = $AnimationPlayers/FtBPlayer
onready var black = $UserInterface/Black
#-------------------------------------------------------------------------------------------------#
#Change Scene Function
func change_scene(delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animPlayer.play("fade")
	yield(animPlayer, "animation_finished")
	yield(get_tree().create_timer(0.5), "timeout")
	animPlayer.play_backwards("fade")
	yield(animPlayer, "animation_finished")
