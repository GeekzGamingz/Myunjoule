#Inherits StateMachine Code
extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
var player_yDistance = 0.0
var player_xDistance = 0.0
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
	call_deferred("stateSet", states.idle)
#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
	if parent.player != null:
		player_xDistance = (parent.player.position.x - parent.position.x)
		player_yDistance = (parent.player.position.y - parent.position.y)
#-------------------------------------------------------------------------------------------------#
#State Logistics
func stateLogic(delta):
	if [states.chase].has(state):
		parent.apply_movement()
#	parent.apply_gravity(delta)
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	if player_xDistance != null && player_yDistance != null:
		match(state):
			states.idle: 
				if parent.player_inSight: return states.chase
				if parent.idleTimer.is_stopped(): return states.walk
			states.walk:
				if parent.idleTimer.is_stopped(): return states.idle
			states.chase: 
				if !parent.player_inSight: return states.idle
			states.attack: pass
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle:
			parent.idleTimer.start()
			parent.spritePlayer.play("idle")
		states.walk:
			parent.idleTimer.start()
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
	match(oldState):
		states.walk, states.chase:
			print("Exiting.")
			parent.motion = Vector2.ZERO
