extends StateMachine
#------------------------------------------------------------------------------#
#Variables
var animations = {
	IDLE = "idle",
	MOVE = "move"
}
var pOrigin
#OnReady Variables
onready var stateLabel: Label = parent.get_node("PlayerOutputs/StateOutput")
onready var storyLabel: Label = parent.get_node("PlayerOutputs/StoryOutput")
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("idle")
	stateAdd("move_up")
	stateAdd("move_down")
	stateAdd("move_right")
	stateAdd("move_left")
	stateAdd("shoot_grapple")
	stateAdd("hooked")
	stateAdd("falling")
	call_deferred("stateSet", states.idle)
#------------------------------------------------------------------------------#
#Input Handler
func _input(event: InputEvent) -> void:
	#Grapple
	if event.is_action_pressed(G.actions.GRAPPLE):
		if parent.target != null:
			var targetPOS = parent.target.global_position
			parent.shoot_grapple = true
			parent.hook.grapple_shoot(targetPOS)
	if event.is_action_pressed(G.actions.GRAPPLE):
		if [states.hooked].has(state):
			parent.shoot_grapple = false
			parent.hook.grapple_release()
			yield(get_tree().create_timer(0.1), "timeout")
			if !parent.hook.hooked:
				#Clears Target
				parent.target = null
				#Reset for POI in Range
				parent.poiDetection.set_deferred("disabled", true)
				yield(get_tree().create_timer(0.01), "timeout")
				parent.poiDetection.set_deferred("disabled", false)
#------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
	storyLabel.text = str(parent.story)
#------------------------------------------------------------------------------#
#State Logistics
# warning-ignore:unused_argument
func stateLogic(delta):
	if ![states.shoot_grapple, states.hooked, states.falling].has(state):
		parent.apply_movement()
	match(state):
		states.move_right: parent.facing = "RIGHT"
		states.move_left: parent.facing = "LEFT"
		states.shoot_grapple: pass
		states.hooked: parent.apply_grapple(delta)
		states.falling: parent.apply_falling(delta)
	parent.motion = parent.move_and_slide(parent.motion)
	parent.apply_facing()
	parent.apply_story()
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idle: return dirMove()
		states.move_up: return dirMove()
		states.move_down: return dirMove()
		states.move_right: return dirMove()
		states.move_left: return dirMove()
		states.shoot_grapple:
			if !parent.shoot_grapple: return states.idle
			if parent.hook.hooked: return states.hooked
		states.hooked: if !parent.hook.hooked: return states.falling
		states.falling:
			if parent.hook.hooked: return states.hooked
			if parent.motion.y == 0: return states.idle
	return null
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle: parent.playBack.travel(animations.IDLE)
		states.move_up: parent.playBack.travel(animations.MOVE)
		states.move_down: parent.playBack.travel(animations.MOVE)
		states.move_right: parent.playBack.travel(animations.MOVE)
		states.move_left: parent.playBack.travel(animations.MOVE)
		states.hooked: parent.collision.set_deferred("disabled", true)
		states.shoot_grapple: pass
#Exit State
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	match(oldState):
		states.hooked:
			parent.collision.set_deferred("disabled", false)
#------------------------------------------------------------------------------#
#Directional Movement Transition
func dirMove():
	if parent.shoot_grapple: return states.shoot_grapple
	if parent.motion.x == parent.max_speed: return states.move_right
	if parent.motion.x == -parent.max_speed: return states.move_left
	if parent.motion.y == parent.max_speed: return states.move_down
	if parent.motion.y == -parent.max_speed: return states.move_up
	if parent.motion == Vector2.ZERO: return states.idle
