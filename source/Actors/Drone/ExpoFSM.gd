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
	stateAdd("hover")
	call_deferred("stateSet", states.idle)

#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])

#-------------------------------------------------------------------------------------------------#
#State Logistics
func stateLogic(delta):
	# parent.apply_bobble_movement()
	if state == states.idle:
		parent.handle_facing()
		parent.apply_idle_movement()
	if state == states.hover:
		parent.apply_hover_movement()

#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idle:
			if not parent.anchored:
				return states.hover
		states.hover:
			if parent.anchored:
				return states.idle

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
