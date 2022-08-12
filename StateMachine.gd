extends Node
class_name StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
var state = null setget stateSet
var prevState = null
var states = {}
#OnReady Variables
onready var parent = get_parent()
#-------------------------------------------------------------------------------------------------#
#State Machine
func _physics_process(delta: float) -> void:
	if state != null:
		stateLogic(delta)
		var transition = transitions(delta)
		if transition != null:
			stateSet(transition)
#State Logistics
# warning-ignore:unused_argument
func stateLogic(delta):
	pass
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	return null
#Enter State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	pass
#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
#Set State
func stateSet(newState):
	prevState = state
	state = newState
	if prevState != null:
		stateExit(prevState, newState)
	if newState != null:
		stateEnter(newState, prevState)
#Add State
func stateAdd(stateName):
	states[stateName] = states.size()
