#Inherits StateMachine Code
extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("phaseNew")
	stateAdd("phaseWaxCrescent")
	stateAdd("phaseFirQuarter")
	stateAdd("phaseWaxGibbous")
	stateAdd("phaseFull")
	stateAdd("phaseWanGibbous")
	stateAdd("phaseLasQuarter")
	stateAdd("phaseWanCrescent")
	call_deferred("stateSet",states.phaseNew)
#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
	parent.moonPhase()
#-------------------------------------------------------------------------------------------------#
#Input Handler
func _input(event: InputEvent) -> void:
	pass
#-------------------------------------------------------------------------------------------------#
#State Machine
#State Logistics
func stateLogic(delta):
	pass
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		#Idle
		states.phaseNew: return setPhase()
		states.phaseWaxCrescent: return setPhase()
		states.phaseFirQuarter: return setPhase()
		states.phaseWaxGibbous: return setPhase()
		states.phaseFull: return setPhase()
		states.phaseWanGibbous: return setPhase()
		states.phaseLasQuarter: return setPhase()
		states.phaseWanCrescent: return setPhase()
	return null
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.phaseNew: pass
#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
#-------------------------------------------------------------------------------------------------#
#Assign Animations
func assign_animation():
	parent.animTree["parameters/conditions/Idle"] = states.phaseNew
#-------------------------------------------------------------------------------------------------#
#Assign Animations
func setPhase():
	if parent.phaseDict["flagNew"] == true: return states.phaseNew
	if parent.phaseDict["flagWaxCrescent"] == true: return states.phaseWaxCrescent
	if parent.phaseDict["flagFirQuarter"] == true: return states.phaseFirQuarter
	if parent.phaseDict["flagWaxGibbous"] == true: return states.phaseWaxGibbous
	if parent.phaseDict["flagFull"] == true: return states.phaseFull
	if parent.phaseDict["flagWanGibbous"] == true: return states.phaseWanGibbous
	if parent.phaseDict["flagLasQuarter"] == true: return states.phaseLasQuarter
	if parent.phaseDict["flagWanCrescent"] == true: return states.phaseWanCrescent
