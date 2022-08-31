extends StateMachine
#------------------------------------------------------------------------------#
#Variables
var animations = {
	IDLE = "idle",
	MOVE = "move"
}
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("idle")
	stateAdd("move_up")
	stateAdd("move_down")
	stateAdd("move_right")
	stateAdd("move_left")
	stateAdd("shoot_grapple")
	call_deferred("stateSet", states.idle)
#------------------------------------------------------------------------------#
#Input Handler
func _input(event: InputEvent) -> void:
	#Grapple
	if event.is_action_pressed(G.actions.GRAPPLE):
		var targetPOS = parent.target
		parent.shoot_grapple = true
		parent.hook.grapple_shoot(targetPOS)
	if event.is_action_released(G.actions.GRAPPLE):
		parent.shoot_grapple = false
		parent.hook.grapple_release()
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Logistics
# warning-ignore:unused_argument
func stateLogic(delta):
	if ![states.shoot_grapple].has(state):
		parent.apply_movement()
	parent.apply_facing()
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idle: return dirMove()
		states.move_up: return dirMove()
		states.move_down: return dirMove()
		states.move_right: return dirMove()
		states.move_left: return dirMove()
		states.shoot_grapple: if !parent.shoot_grapple: return states.idle
	return null
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle: parent.playBack.travel(animations.IDLE)
		states.move_up: parent.playBack.travel(animations.MOVE)
		states.move_down: parent.playBack.travel(animations.MOVE)
		states.move_right: 
			parent.playBack.travel(animations.MOVE)
			parent.facing = "RIGHT"
		states.move_left:
			parent.playBack.travel(animations.MOVE)
			parent.facing = "LEFT"
#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
#------------------------------------------------------------------------------#
#Directional Movement Transition
func dirMove():
	if parent.shoot_grapple: return states.shoot_grapple
	if parent.motion == Vector2.ZERO: return states.idle
	if parent.motion.x == parent.max_speed: return states.move_right
	if parent.motion.x == -parent.max_speed: return states.move_left
	if parent.motion.y == parent.max_speed: return states.move_down
	if parent.motion.y == -parent.max_speed: return states.move_up
