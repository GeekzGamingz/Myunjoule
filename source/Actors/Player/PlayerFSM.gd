#Inherits StateMachine Code
extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")

var animations = {
	IDLE = "rowbit_idle",
	MOVE_LEFT  = "rowbit_move_left",
	MOVE_RIGHT = "rowbit_move_right",
	OUCHIE = "rowbit_ouchie",
	TRANSITION = "rowbit_transition",
	DEACTIVATING = "deactivating",
	DEACTIVATED = "deactivated",
	GRAPPLE_PREP = "rowbit_grappling_prep",
	GRAPPLE_LAND = "rowbit_grappling_land",
	GRAPPLE_HARDLAND = "rowbit_grappling_hardlanding",
	SLEP = "rowbit_slep"
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
	stateAdd("dialog")
	stateAdd("ouchie")
	stateAdd("transition")
	stateAdd("deactivatING")
	stateAdd("deactivatED")
	stateAdd("slep")
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
	if event.is_action_pressed("activate") and parent.grappling.can_grapple:
		call_deferred("stateSet", states.grappling)
		parent.grappling.is_grappling = true


#-------------------------------------------------------------------------------------------------#
#State Machine
#State Logistics
func stateLogic(delta):
	if parent.is_falling:
		parent.apply_gravity(delta)
	if ![states.dialog, states.transition, states.ouchie,
		 states.deactivatING, states.deactivatED, states.slep].has(state):
		parent.handle_movement()
	parent.apply_movement()


#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idle: return basicMovement()
		states.move_left: return basicMovement()
		states.move_right: return basicMovement()
		states.move_up: return basicMovement()
		states.move_down: return basicMovement()
		
		states.fall:
			if not parent.is_falling:
				return states.idle
		
		states.grappling:
			if not parent.grappling.is_grappling:
				return states.idle
		
		states.dialog:
			if !parent.talking.is_talking: return states.idle
		
		states.ouchie:
			if parent.ouchieTimer.is_stopped(): return states.idle
		
		states.transition:
			if !parent.inTransition: return states.idle
		
		states.deactivatING:
			if !parent.is_deactivating: return states.deactivatED
		
		states.deactivatED:
			if !parent.deactivatedTimer.is_stopped(): return states.idle
			
		states.slep:
			if !parent.is_slep: return states.idle
			
	return null
#Enter State
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idle:
			parent.playBack.travel(animations.IDLE)
		
		states.move_left:
			parent.playBack.travel(animations.MOVE_LEFT)
			parent.gridSnapper.scale.x = 1
		
		states.move_right:
			parent.playBack.travel(animations.MOVE_RIGHT)
			parent.gridSnapper.scale.x = -1
		
		states.dialog:
			parent.motion = Vector2.ZERO
		
		states.ouchie:
			parent.motion = Vector2.ZERO
			parent.playBack.start(animations.OUCHIE)
		
		states.grappling:
			parent.playBack.start(animations.GRAPPLE_PREP)
			var fall_starts = get_tree().get_nodes_in_group("fall_start")
			for fall_start in fall_starts:
				fall_start.set_deferred("monitoring", false)
			parent.story = 1
			parent.set_story()
			parent.set_collision_disabled(true)
		
		states.fall:
			parent.story = 0
		
		states.transition:
			parent.playBack.start(animations.TRANSITION)
		
		states.deactivatING:
			parent.motion = Vector2.ZERO
			parent.playBack.start(animations.DEACTIVATING)
			yield(get_tree().create_timer(5), "timeout")
			get_tree().root.get_node("Moon/YSort/UI/UserInterface").change_scene()
			parent.camera.limit_left = -720
			parent.camera.limit_right = 720
			yield(get_tree().create_timer(1), "timeout")
			parent.is_deactivating = false
			parent.global_position = Vector2(-500, 100)
			parent.chargeEnergy(25)
			
		states.deactivatED:
			parent.motion = Vector2.ZERO
			parent.playBack.start(animations.DEACTIVATED)
			parent.deactivatedTimer.start()
		
		states.slep:
			var moon = get_tree().root.get_node("Moon/ParallaxBackground/ParallaxLayer2/MoonAnchor/")
			moon.get_node("Moon/AnimationPlayers/SpritePlayer").playback_speed = 25
			parent.motion = Vector2.ZERO
			parent.playBack.start(animations.SLEP)
			moon.get_node("Moon").rotation_speed += 5
			yield(get_tree().create_timer(5), "timeout")
			get_tree().root.get_node("Moon/YSort/UI/UserInterface").change_scene()
			yield(get_tree().create_timer(1), "timeout")
			moon.get_node("Moon").rotation_speed -= 5
			moon.get_node("Moon/AnimationPlayers/SpritePlayer").playback_speed = 1
			parent.chargeEnergy(100)
			parent.is_slep = false
#Exit State
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	match(oldState):
		states.grappling:
			var fall_starts = get_tree().get_nodes_in_group("fall_start")
			for fall_start in fall_starts:
				fall_start.set_deferred("monitoring", true)
			parent.set_collision_disabled(false)
		states.fall:
			parent.set_story()


#-------------------------------------------------------------------------------------------------#
#Assign Animations
func assign_animation():
	parent.animTree["parameters/conditions/Idle"] = states.idle



#-------------------------------------------------------------------------------------------------#
func basicMovement():
	if parent.is_slep: return states.slep
	if parent.is_deactivating: return states.deactivatING
	if parent.inTransition: return states.transition
	if parent.is_falling: return states.fall
	if parent.talking.is_talking: return states.dialog
	if !parent.ouchieTimer.is_stopped(): return states.ouchie
	if parent.move_dir == 0: return states.idle
	if parent.move_dir < 0: return states.move_left
	if parent.move_dir > 0: return states.move_right
	if parent.z_move_dir < 0: return states.move_up
	if parent.z_move_dir > 0: return states.move_down
