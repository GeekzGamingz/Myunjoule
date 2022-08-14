#Inherits Actor Code
extends Actor
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Animation Nodes
onready var spritePlayer = $AnimationPlayers/SpritePlayer
onready var fxPlayer = $AnimationPlayers/EffectsPlayer
onready var animTree = $AnimationPlayers/AnimationTree
onready var playBack = animTree.get("parameters/playback")
onready var currentState = playBack.get_current_node()

var move_dir: int = 0
var old_move_dir: int = 0
var snap: Vector2 = Vector2.DOWN
#-------------------------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	pass
#-------------------------------------------------------------------------------------------------#
#Applies Gravity
func apply_gravity(delta):
	motion.y += gravity * delta

func handle_move_input() -> void:
	old_move_dir = move_dir
	move_dir = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	
	# Accel/Decel
	if move_dir != 0:
		motion.x = lerp(motion.x, move_dir * max_speed, lerp(0.0, max_acceleration, acceleration_step))
	else:
		motion.x = lerp(motion.x, 0, lerp(0.0, friction, friction_step))

func apply_movement() -> void:
	motion = move_and_slide_with_snap(motion, snap, Vector2.UP, true, 4, deg2rad(45), false)
