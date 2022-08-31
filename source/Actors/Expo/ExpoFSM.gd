extends StateMachine
#------------------------------------------------------------------------------#
#Variables
var animations = {
	IDLE = "idle",
	ALERT = "alert"
}
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("idle")
	stateAdd("hover")
	stateAdd("alert")
	call_deferred("stateSet", states.idle)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Logistics
func stateLogic(_delta):
	match(state):
		states.idle:
			parent.movement_idle()
			G.PLAYER.hook.grapple_release() #Updates TipPOS Location
		states.hover: parent.movement_hover()
		states.alert: pass
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idle: if parent.detected: return states.hover
		states.hover: if !parent.detected: return states.idle
		states.alert: pass
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle, states.hover: parent.playBack.travel(animations.IDLE)
		states.alert: parent.playBack.travel(animations.ALERT)
#Exit State
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	match(oldState):
		states.alert: pass
