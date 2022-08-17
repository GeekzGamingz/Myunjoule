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
	stateAdd("alert")
	call_deferred("stateSet", states.idle)

#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])

#-------------------------------------------------------------------------------------------------#
#State Logistics
func stateLogic(_delta):
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
			if parent.alert:
				return states.alert
		states.alert:
			if not parent.alert:
				return states.hover

#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle, states.hover:
			parent.get_node("AnimationPlayer").play("expo_bobble")
		states.alert:
			parent.get_node("AnimationPlayer").play("expo_alert")

#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
