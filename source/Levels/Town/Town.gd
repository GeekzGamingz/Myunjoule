extends Node2D
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var tideAnimator = get_tree().root.get_node("Moon/Level_Beach/YSort/UI/UserInterface/AnimationPlayers/TideStatusPlayer")
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	pass
#-------------------------------------------------------------------------------------------------#
#Remote Animated Tide Function
func lowTide():
	$AnimationPlayers/AnimationPlayer.play("idle_low")
func midTide():
	tideAnimator.play("mid")
	$AnimationPlayers/AnimationPlayer.play("idle_mid")
func highTide():
	tideAnimator.play("high")
	$AnimationPlayers/AnimationPlayer.play("idle_high")
#-------------------------------------------------------------------------------------------------#
