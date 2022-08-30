extends Actor
#------------------------------------------------------------------------------#
#Variables
var facing = "RIGHT"
var target
#Bool Variables
var grapple_prep: bool = false
#OnReady Variables
onready var sprite: Sprite = $PlayerSprite
onready var expoAnchor: Position2D = $Facing/ExpoAnchor
onready var expoSprite: Sprite = G.EXPO.get_node("ExpoSprite")
onready var hook: Position2D = $Facing/GrapplingHook
#Animation Nodes
onready var spritePlayer: AnimationPlayer = $AnimationPlayers/SpritePlayer
onready var animTree: AnimationTree = $AnimationPlayers/AnimationTree
onready var playBack = animTree.get("parameters/playback")
onready var currentState = playBack.get_current_node()
#------------------------------------------------------------------------------#
#Movement
func apply_movement():
	motion = Vector2.ZERO
	#Basic Movement
	if Input.is_action_pressed(G.actions.RIGHT): motion.x += 1
	if Input.is_action_pressed(G.actions.LEFT): motion.x -= 1
	if Input.is_action_pressed(G.actions.DOWN): motion.y += 1
	if Input.is_action_pressed(G.actions.UP): motion.y -= 1
	motion = motion.normalized() * max_speed #Normalizes Diagonal Movement
	motion = move_and_slide(motion)
#Gravity
func apply_gravity(delta):
	motion.y += gravity * delta
#------------------------------------------------------------------------------#
#Facing
func apply_facing():
	sprite.flip_h = !sprite.flip_h
	expoSprite.flip_h = !expoSprite.flip_h
	expoAnchor.position.x *= -1
#	hook.position.x *= -1
#------------------------------------------------------------------------------#
#POI Detection
#Area Entered
func _on_POIDetection_area_entered(area: Area2D) -> void:
	if area.is_in_group("POI"):
		target = area
		G.EXPO.detected = true
		G.EXPO.POI = target.global_position
#Area Exited
func _on_POIDetection_area_exited(area: Area2D) -> void:
	if area.is_in_group("POI"):
		G.EXPO.detected = false
#------------------------------------------------------------------------------#
