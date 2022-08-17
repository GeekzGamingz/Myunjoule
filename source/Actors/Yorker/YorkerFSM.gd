#Inherits StateMachine Code
extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("idle")
	stateAdd("dialog")
	call_deferred("stateSet",states.idle)
#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
#-------------------------------------------------------------------------------------------------#
#Input Handler
func _input(_event: InputEvent) -> void:
	pass
#-------------------------------------------------------------------------------------------------#
#State Machine
#State Logistics
func stateLogic(_delta):
	pass
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		#Idle
		states.idle:
			pass
	return null
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle:
			pass
#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
#-------------------------------------------------------------------------------------------------#
#Assign Animations
func assign_animation():
	parent.animTree["parameters/conditions/Idle"] = states.idle
