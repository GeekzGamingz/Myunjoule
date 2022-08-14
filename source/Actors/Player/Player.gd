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
var z_move_dir: int = 0
var old_z_move_dir: int = 0
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
	old_z_move_dir = z_move_dir
	print(z_move_dir)
	move_dir = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	# Make a z_move_dir var, to determine if W or S are being pressed
	z_move_dir = -int(Input.is_action_pressed("move_forward")) + int(Input.is_action_pressed("move_backward"))
	# Accel/Decel
	if move_dir != 0:
		motion.x = lerp(motion.x, move_dir * max_speed, lerp(0.0, max_acceleration, acceleration_step))
	else:
		motion.x = lerp(motion.x, 0, lerp(0.0, friction, friction_step))
	
	if z_move_dir != 0:
		motion.y = 0
		# Add logic here to adjust the z-index, collision layers, y position, and scale
		# Let's start with a single pixel encapsulating a single collision layer
		print("Setting Y motion")
		motion.y += z_move_dir * 10
		# So far, my main issue is trying to clamp the vertical movement.
		# We may need to define a point in each level/area and I will say,
		# "You can go 50 pixels (probably more, maybe less) from the Y position of this point"
		pass
	else:
		# Yes, just to see how it feels. Prioritize the base movement first, though.
		# Still gotta set y to 0 here, regardless, so when we stop pressing either
		# direction we don't preserve the movement
		motion.y = 0
		pass

func apply_movement() -> void:
	print(motion)
	motion = move_and_slide_with_snap(motion, snap, Vector2.UP, true, 4, deg2rad(45), false)
