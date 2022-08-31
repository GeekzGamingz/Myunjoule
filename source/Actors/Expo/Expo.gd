extends Actor
#------------------------------------------------------------------------------#
#Variables
var POI = Vector2.ZERO
#Bool Variables
var detected: bool = false
#OnReady Variables
onready var anchor: Position2D = G.PLAYER.get_node("Anchors/ExpoAnchor")
#Animation Nodes
onready var spritePlayer: AnimationPlayer = $AnimationPlayers/ExpoPlayer
onready var animTree: AnimationTree = $AnimationPlayers/AnimationTree
onready var playBack = animTree.get("parameters/playback")
onready var currentState = playBack.get_current_node()
#------------------------------------------------------------------------------#
#Applies Idle Movement
func movement_idle() -> void:
	if self.position.distance_to(anchor.global_position) < 40:
		self.position = lerp(self.position, anchor.global_position,
						lerp(0, 0.1, 0.6))
	else:
		self.position = lerp(self.position, anchor.global_position,
						lerp(0, 0.075, 0.5))
#Applies Hover Movement
func movement_hover() -> void:
	self.position = lerp(self.position, POI, lerp(0, 0.075, 1.0))
