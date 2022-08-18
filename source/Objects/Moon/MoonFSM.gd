#Inherits StateMachine Code
extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")
onready var phaseAnimator = get_tree().root.get_node(
	"Moon/Level_Beach/YSort/UI/UserInterface/AnimationPlayers/MoonPhasePlayer")
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
	if parent.phaseDict["flagNew"] == true:
		phaseAnimator.play("new")
		return states.phaseNew
	if parent.phaseDict["flagWaxCrescent"] == true:
		phaseAnimator.play("waxCres")
		return states.phaseWaxCrescent
	if parent.phaseDict["flagFirQuarter"] == true:
		phaseAnimator.play("firQuar")
		return states.phaseFirQuarter
	if parent.phaseDict["flagWaxGibbous"] == true:
		phaseAnimator.play("waxGibb")
		return states.phaseWaxGibbous
	if parent.phaseDict["flagFull"] == true:
		phaseAnimator.play("full")
		return states.phaseFull
	if parent.phaseDict["flagWanGibbous"] == true:
		phaseAnimator.play("wanGibb")
		return states.phaseWanGibbous
	if parent.phaseDict["flagLasQuarter"] == true:
		phaseAnimator.play("lasQuar")
		return states.phaseLasQuarter
	if parent.phaseDict["flagWanCrescent"] == true:
		phaseAnimator.play("wanCres")
		return states.phaseWanCrescent
