#Inherits StateMachine Code
extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")

var animations = {
	IDLE = "rowbit_idle",
	MOVE_LEFT  = "rowbit_move_left",
	MOVE_RIGHT = "rowbit_move_right"
}

#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("idle")
	stateAdd("fall")
	stateAdd("move_left")
	stateAdd("move_right")
	stateAdd("move_up")
	stateAdd("move_down")
	stateAdd("grappling")
	# Set the starting state
	call_deferred("stateSet",states.idle)


#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])


#-------------------------------------------------------------------------------------------------#
#Input Handler
func _input(event: InputEvent) -> void:
	# Would want some tie in here to the drone selection system
	if event.is_action_pressed("activate") and $"../GrapplingHook".can_grapple:
		call_deferred("stateSet", states.grappling)
		parent.grappling.is_grappling = true
	pass


#-------------------------------------------------------------------------------------------------#
#State Machine
#State Logistics
func stateLogic(delta):
	if parent.is_falling:
		parent.apply_gravity(delta)
	parent.handle_movement()
	parent.apply_movement()


#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idle:
			if parent.move_dir < 0:
				return states.move_left
			if parent.move_dir > 0:
				return states.move_right
			if parent.z_move_dir < 0:
				return states.move_up
			if parent.z_move_dir > 0:
				return states.move_down
			if parent.is_falling:
				return states.fall
		
		states.fall:
			if not parent.is_falling:
				return states.idle
		
		states.move_left:
			if parent.move_dir == 0:
				return states.idle
			if parent.move_dir > 0:
				return states.move_right
		
		states.move_right:
			if parent.move_dir == 0:
				return states.idle
			if parent.move_dir < 0:
				return states.move_left
		
		states.move_up:
			if parent.z_move_dir == 0:
				return states.idle
		
		states.move_down:
			if parent.z_move_dir == 0:
				return states.idle
		
		states.grappling:
			if not parent.grappling.is_grappling:
				return states.idle
	return null


#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle:
			parent.spritePlayer.play(animations.IDLE)
		
		states.move_left:
			parent.spritePlayer.play(animations.MOVE_LEFT)
		
		states.move_right:
			parent.spritePlayer.play(animations.MOVE_RIGHT)


#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass


#-------------------------------------------------------------------------------------------------#
#Assign Animations
func assign_animation():
	parent.animTree["parameters/conditions/Idle"] = states.idle
