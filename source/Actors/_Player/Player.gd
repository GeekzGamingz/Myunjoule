extends Actor
#------------------------------------------------------------------------------#
#Variables
var facing = "RIGHT"
var target
#Bool Variables
var shoot_grapple: bool = false
#OnReady Variables
onready var sprite: Sprite = $PlayerSprite
onready var expoAnchor: Position2D = $Anchors/ExpoAnchor
onready var expoSprite: Sprite = G.EXPO.get_node("ExpoSprite")
onready var hook: Position2D = $Anchors/GrapplingHook
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
	if facing == "LEFT":
		sprite.flip_h = true
		expoSprite.flip_h = true
		expoAnchor.position.x = 30
	else:
		sprite.flip_h = false
		expoSprite.flip_h = false
		expoAnchor.position.x = -30
#------------------------------------------------------------------------------#
#POI Detection
#Areas
#Area Entered
func _on_POIDetection_area_entered(area: Area2D) -> void:
	pass
#Area Exited
func _on_POIDetection_area_exited(area: Area2D) -> void:
	pass
#Bodies
#Body Entered
func _on_POIDetection_body_entered(body: Node) -> void:
	if body.is_in_group("Grapple"):
		target = body
		G.EXPO.detected = true
		G.EXPO.POI = target.global_position
#Body Exited
func _on_POIDetection_body_exited(body: Node) -> void:
	if body.is_in_group("Grapple"):
		G.EXPO.detected = false
#------------------------------------------------------------------------------#



