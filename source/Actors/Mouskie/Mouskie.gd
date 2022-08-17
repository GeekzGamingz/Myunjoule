#Inherits Actor Code
extends Actor
#-------------------------------------------------------------------------------------------------#
#Variables
var player = null
var rng = RandomNumberGenerator.new()
var Facing = "Left"
var oldFacing
var direction = Vector2.ZERO
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
	$LightAttack/CollisionShape2D.set_deferred("disabled", true)
#-------------------------------------------------------------------------------------------------#
#Applies Gravity
func apply_gravity(delta):
	motion.y += gravity * delta
#Applies Movement
func apply_movementChase():
	var distance = Vector2(get_child(0).player_xDistance, get_child(0).player_yDistance)
	motion = lerp(motion, distance.normalized() * 100, 0.3)
	motion = move_and_slide(motion, Vector2.UP)
func get_direction():
	rng.randomize()
	var rngDistance = rng.randf_range(-20, 20)
	var distance = Vector2(rngDistance, rngDistance)
	direction = distance
func apply_movementWalk(dir: Vector2):
	motion = lerp(motion, dir.normalized() * 100, 0.3)
	motion = move_and_slide(motion, Vector2.UP)
#-------------------------------------------------------------------------------------------------#
#Flip Sprite & Collision
func flipMouskie():
	if oldFacing != Facing:
		if motion.x < 0:
			get_node("MouskieSprite").set_flip_h(true)
			get_node("EffectsSprite").set_flip_h(true)
			get_node("LightAttack/CollisionShape2D").position = Vector2(-24, 3)
			$LCollision.set_deferred("disabled", false)
			$RCollision.set_deferred("disabled", true)
			Facing = "Left"
		elif motion.x > 0:
			get_node("MouskieSprite").set_flip_h(false)
			get_node("EffectsSprite").set_flip_h(false)
			get_node("LightAttack/CollisionShape2D").position = Vector2(24, 3)
			$LCollision.set_deferred("disabled", true)
			$RCollision.set_deferred("disabled", false)
			Facing = "Right"
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
	$LightAttack/CollisionShape2D.set_deferred("disabled", false)
func attackDisable():
	$LightAttack/CollisionShape2D.set_deferred("disabled", true)
