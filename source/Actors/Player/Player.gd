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
var is_falling = false
#-------------------------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	$LandingDetector.connect("area_entered", self, "enable_collision")
#-------------------------------------------------------------------------------------------------#
#Applies Gravity
func apply_gravity(delta):
	motion.y += gravity * delta

func handle_move_input() -> void:
	old_move_dir = move_dir
	old_z_move_dir = z_move_dir
	
	move_dir = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	# Make a z_move_dir var, to determine if W or S are being pressed
	z_move_dir = -int(Input.is_action_pressed("move_forward")) + int(Input.is_action_pressed("move_backward"))
	
	# Accel/Decel
	if move_dir != 0:
		motion.x = lerp(motion.x, move_dir * max_speed, lerp(0.0, max_acceleration, acceleration_step))
	else:
		motion.x = lerp(motion.x, 0, lerp(0.0, friction, friction_step))
	
	if not is_falling:
		if z_move_dir != 0:
			motion.y = lerp(motion.y, z_move_dir * max_speed, lerp(0.0, max_acceleration, acceleration_step))
		else:
			motion.y = lerp(motion.y, 0, lerp(0.0, friction, friction_step))

func apply_movement() -> void:
	motion = move_and_slide(motion, Vector2.UP)

func set_is_falling(falling: bool) -> void:
	is_falling = falling
	if (falling):
		$CollisionShape2D.set_deferred("disabled", true)

func enable_collision(area: Area2D) -> void:
	if area.is_in_group("fall_end"):
		$CollisionShape2D.set_deferred("disabled", false)
