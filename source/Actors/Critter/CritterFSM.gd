#Inherits StateMachine Code
extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
var player_yDistance
var player_xDistance
#Bool Variables
var attacking = false
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("idle")
	stateAdd("walk")
	stateAdd("chase")
	stateAdd("attack")
	call_deferred("stateSet", states.walk)
#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
	if parent.player != null:
		player_xDistance = (parent.player.position.x - parent.position.x)
		player_yDistance = (parent.player.position.y - parent.position.y)
		print("X: ", player_xDistance, "Y: ", player_yDistance)
#-------------------------------------------------------------------------------------------------#
#State Logistics
func stateLogic(delta):
	parent.apply_movement()
	parent.apply_gravity(delta)
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	if player_xDistance != null && player_yDistance != null:
		match(state):
			states.idle: pass
			states.walk: pass
			states.chase: pass
			states.attack: pass
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle:
			parent.spritePlayer.play("idle")
		states.walk:
			parent.spritePlayer.play("walk")
		states.chase:
			parent.spritePlayer.play("chase")
		states.attack:
			parent.spritePlayer.play("attack")
			attacking = true
			yield(parent.spritePlayer, "animation_finished")
			attacking = false
#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
