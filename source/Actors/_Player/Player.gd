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
onready var collision: CollisionShape2D = $CollisionShape2D
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
	#Normalizes Diagonal Movement
	motion = motion.normalized() * max_speed
#Gravity
func apply_grapple(delta):
	var origin = target.get_parent().get_node("PlayerOrigin")
	self.global_position = lerp(self.global_position, origin.global_position,
						   lerp(0, 0.075, 1))
	#Swinging
	if Input.is_action_pressed(G.actions.LEFT):
		origin.linear_velocity.x -= 1
		facing = "LEFT"
	if Input.is_action_pressed(G.actions.RIGHT):
		origin.linear_velocity.x += 1
		facing = "RIGHT"
	if Input.is_action_pressed("ui_down"):
		origin.get_parent().rest_length += 1
	if Input.is_action_pressed("ui_up"):
		origin.get_parent().rest_length = 1
	#Gravity
	origin.linear_velocity.y += gravity * delta
#------------------------------------------------------------------------------#
#Facing
func apply_facing():
	if facing == "LEFT":
		sprite.flip_h = true
		sprite.position.x = 4
		expoSprite.flip_h = true
		expoAnchor.position.x = 30
	else:
		sprite.flip_h = false
		sprite.position.x = -4
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



