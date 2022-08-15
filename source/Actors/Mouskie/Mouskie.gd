#Inherits Actor Code
extends Actor
#-------------------------------------------------------------------------------------------------#
#Variables
var player = null
var rng = RandomNumberGenerator.new()
var Direction = "Left"
var oldDirection
#Bool Variables
var player_inSight = false
var player_inThreat = false
#OnReady Variables
onready var spritePlayer = $AnimationPlayers/SpritePlayer
onready var fxPlayer = $AnimationPlayers/EffectsPlayer
onready var idleTimer: Timer = $Timers/idleTimer
onready var attackTimer: Timer = $Timers/attackTimer
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	$Threat/CollisionShape2D.set_deferred("disabled", false)
#-------------------------------------------------------------------------------------------------#
#Applies Gravity
func apply_gravity(delta):
	motion.y += gravity * delta
#Applies Movement
func apply_movementChase():
	var distance = Vector2(get_child(0).player_xDistance, get_child(0).player_yDistance)
	motion = lerp(motion, distance.normalized() * 50, 0.3)
	motion = move_and_slide(motion, Vector2.UP)
func apply_movementWalk():
	rng.randomize()
	var rngDistance1 = rng.randf_range(-50, 50)
	var rngDistance2 = rng.randf_range(-50, 50)
	var distance = Vector2(rngDistance1, rngDistance1)
	motion = lerp(motion, distance.normalized() * 100, 0.3)
	motion = move_and_slide(motion, Vector2.UP)
#-------------------------------------------------------------------------------------------------#
#Flip Sprite & Collision
func flipMouskie():
	if oldDirection != Direction:
		if motion.x < 0:
			get_node("MouskieSprite").set_flip_h(true)
			$LCollision.set_deferred("disabled", false)
			$RCollision.set_deferred("disabled", true)
			Direction = "Left"
		else:
			get_node("MouskieSprite").set_flip_h(false)
			$LCollision.set_deferred("disabled", true)
			$RCollision.set_deferred("disabled", false)
			Direction = "Right"
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
func _on_Threat_area_entered(area: Area2D) -> void:
	if area.name == "PlayerArea":
		player = area.get_parent()
		player_inThreat = true
#Out of Sight
func _on_Threat_area_exited(area: Area2D) -> void:
	if area.name == "PlayerArea":
		player_inThreat = false
#-------------------------------------------------------------------------------------------------#
#Attack
func attackEnable():
	$Facing/LightAttack/CollisionShape2D.set_deferred("disabled", false)
func attackDisable():
	$Facing/LightAttack/CollisionShape2D.set_deferred("disabled", true)
