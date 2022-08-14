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
	# stateAdd("fall")
	stateAdd("move_left")
	stateAdd("move_right")
	stateAdd("move_forward")
	stateAdd("move_backward")
	# Set the starting state
	call_deferred("stateSet",states.idle)


#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])


#-------------------------------------------------------------------------------------------------#
#Input Handler
func _input(event: InputEvent) -> void:
	pass


#-------------------------------------------------------------------------------------------------#
#State Machine
#State Logistics
func stateLogic(delta):
	# parent.apply_gravity(delta)
	parent.handle_move_input()
	parent.apply_movement()


#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		#Idle
		states.idle:
			if parent.move_dir < 0:
				return states.move_left
			if parent.move_dir > 0:
				return states.move_right
#			if not parent.is_on_floor():
#				return states.fall
#		states.fall:
#			if parent.is_on_floor():
#				return states.idle
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
