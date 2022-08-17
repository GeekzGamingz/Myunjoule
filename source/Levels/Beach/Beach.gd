extends Node2D
#-------------------------------------------------------------------------------------------------#
func lowTide():
	$AnimationPlayers/AnimationPlayer.play("idle_low")
func midTide():
	$AnimationPlayers/AnimationPlayer.play("idle_mid")
func highTide():
	$AnimationPlayers/AnimationPlayer.play("idle_high")
