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
	stateAdd("grapple")
	call_deferred("stateSet", states.idle)
#------------------------------------------------------------------------------#
#Input Handler
func _input(event: InputEvent) -> void:
	#Grapple
	if event.is_action_pressed(G.actions.GRAPPLE):
		var targetPOS = parent.target.global_position
		parent.grapple_prep = true
		parent.hook.grapple_shoot(targetPOS)
	if event.is_action_released(G.actions.GRAPPLE):
		parent.grapple_prep = false
		parent.hook.grapple_release()
	#Facing
	if event.is_action_pressed("ui_right") && parent.facing == "LEFT":
		parent.facing = "RIGHT"
		parent.apply_facing()
	elif event.is_action_pressed("ui_left") && parent.facing == "RIGHT":
		parent.facing = "LEFT"
		parent.apply_facing()
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
#------------------------------------------------------------------------------#
#State Logistics
# warning-ignore:unused_argument
func stateLogic(delta):
	if ![states.grapple].has(state):
		parent.apply_movement()
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idle: return dirMove()
		states.move_up: return dirMove()
		states.move_down: return dirMove()
		states.move_right: return dirMove()
		states.move_left: return dirMove()
		states.grapple:
			if !parent.grapple_prep: return states.idle
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
		states.move_left:
			parent.playBack.travel(animations.MOVE)
#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
#------------------------------------------------------------------------------#
#Directional Movement Transition
func dirMove():
	if parent.grapple_prep: return states.grapple
	if parent.motion == Vector2.ZERO: return states.idle
	if parent.motion.x == parent.max_speed: return states.move_right
	if parent.motion.x == -parent.max_speed: return states.move_left
	if parent.motion.y == parent.max_speed: return states.move_down
	if parent.motion.y == -parent.max_speed: return states.move_up
