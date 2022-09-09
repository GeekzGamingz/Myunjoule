extends Actor
#------------------------------------------------------------------------------#
#Variables
var target = null
#String Variables
var facing = "RIGHT"
var story = "GROUND"
#Bool Variables
var shoot_grapple: bool = false
#OnReady Variables
onready var sprite: Sprite = $PlayerSprite
onready var expoAnchor: Position2D = $Anchors/ExpoAnchor
onready var expoSprite: Sprite = G.EXPO.get_node("ExpoSprite")
onready var hook: Position2D = $Anchors/GrapplingHook
onready var collision: CollisionShape2D = $CollisionShape2D
onready var poiDetection: CollisionShape2D = $PlayerAreas/POIDetection/CollisionShape2D
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
#Falling
func apply_falling(delta):
	if Input.is_action_pressed(G.actions.RIGHT): motion.x += 1
	if Input.is_action_pressed(G.actions.LEFT): motion.x -= 1
	motion.y += gravity * delta
#------------------------------------------------------------------------------#
#Grapple
func apply_grapple(delta):
	var spring = target.get_parent()
	var origin = target.get_parent().get_node("PlayerOrigin")
	#Snaps to Global Position
	self.global_position = lerp(self.global_position, origin.global_position,
						lerp(0, 0.075, 1))
	#Matches Player Motion to Origin Velocity
	self.motion = lerp(self.motion, origin.linear_velocity,
						lerp(0, 0.075, 1))
	#Swinging
	if Input.is_action_pressed(G.actions.LEFT):
		origin.linear_velocity.x -= 1
		spring.damping = 16
		facing = "LEFT"
	if Input.is_action_pressed(G.actions.RIGHT):
		origin.linear_velocity.x += 1
		spring.damping = 16
		facing = "RIGHT"
	#Ascend/Descend
	if Input.is_action_pressed(G.actions.DOWN):
		origin.get_parent().rest_length += 1
	if Input.is_action_pressed(G.actions.UP):
		if spring.rest_length > 1:
			spring.rest_length -= 1
	#Reel In
	if Input.is_action_just_released(G.actions.ACTIVATE):
		spring.rest_length = 1
		spring.damping = 1
		spring.stiffness = 64
		yield(get_tree().create_timer(0.5), "timeout")
		spring.stiffness = 20
	#Gravity
	origin.linear_velocity.y += gravity * delta
#------------------------------------------------------------------------------#
#Switch Story
func apply_story():
	for zone in G.ZONES.get_children():
		var collisions = zone.get_node("Objects/Grappling/Collision/")
		for area in collisions.get_children():
			var poly = area.get_node("CollisionPolygon2D")
			check_story(poly)
#Story Collisions
func check_story(poly):
	match(story):
		"GROUND": 
			if poly.get_groups()[0] in ["Bottom", "Top"]:
				poly.set_disabled(false)
			else: poly.set_disabled(true)
		"STORY1": 
			if poly.get_groups()[0] in ["Bottom", "Story1"]:
				poly.set_disabled(false)
			else: poly.set_disabled(true)
		"STORY2": 
			if poly.get_groups()[0] in ["Bottom", "Story2"]:
				poly.set_disabled(false)
			else: poly.set_disabled(true)
		"FALLING": 
			if poly.get_groups()[0] in ["Bottom"]:
				poly.set_disabled(false)
			else: poly.set_disabled(true)
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
func _on_POIDetection_area_entered(_area: Area2D) -> void:
	pass
#Area Exited
func _on_POIDetection_area_exited(_area: Area2D) -> void:
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



