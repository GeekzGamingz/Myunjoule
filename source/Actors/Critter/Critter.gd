#Inherits Actor Code
extends Actor
#-------------------------------------------------------------------------------------------------#
#Variables
var player
#Bool Variables
var player_inSight = false
#OnReady Variables
onready var spritePlayer = $AnimationPlayers/SpritePlayer
onready var fxPlayer = $AnimationPlayers/EffectsPlayer
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	$Threat/CollisionShape2D.set_deferred("disabled", false)
#-------------------------------------------------------------------------------------------------#
#Applies Gravity
func apply_gravity(delta):
	motion.y += gravity * delta
#Applies Movement
func apply_movement():
	motion = move_and_slide(motion, Vector2.UP)
#-------------------------------------------------------------------------------------------------#
#Sight
#In Sight
func _on_Sight_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		player = area.get_parent()
		player_inSight = true
#Out of Sight
func _on_Sight_area_exited(area: Area2D) -> void:
	if area.name == "PlayerArea":
		player_inSight = false
#-------------------------------------------------------------------------------------------------#
#Attack
func attackEnable():
	$Facing/LightAttack/CollisionShape2D.set_deferred("disabled", false)
func attackDisable():
	$Facing/LightAttack/CollisionShape2D.set_deferred("disabled", true)
