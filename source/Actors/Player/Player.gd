#Inherits Actor Code
extends Actor
#-------------------------------------------------------------------------------------------------#
#Variables
var move_dir: int = 0
var old_move_dir: int = 0
var z_move_dir: int = 0
var old_z_move_dir: int = 0
var snap: Vector2 = Vector2.DOWN
var is_falling = false
var is_deactivating = false
var inTransition = false
var talking = {
	"is_talking": true,
	"can_talk": false,
}
var grappling = {
	"is_grappling": false,
	"can_grapple": false,
}
var items = {
	"grappling_hook": true,
}
#OnReady Variables
onready var iFrameTimer: Timer = $Timers/iFrameTimer
onready var ouchieTimer: Timer = $Timers/OuchieTimer
onready var deactivatedTimer: Timer = $Timers/DeactivatedTimer

onready var gridSnapper: Area2D = $GridSnapper
onready var energy = max_energy setget set_energy
#Animation Nodes
onready var spritePlayer = $AnimationPlayers/SpritePlayer
onready var fxPlayer = $AnimationPlayers/EffectsPlayer
onready var animTree = $AnimationPlayers/AnimationTree
onready var playBack = animTree.get("parameters/playback")
onready var currentState = playBack.get_current_node()
#Exported Variables
export(float) var max_energy = 100.0
#Signals
signal detected_poi
signal poi_lost
signal energyUpdate_drain(energy)
signal energyUpdate_charge(energy)
#-------------------------------------------------------------------------------------------------#
#Ready Method
func _ready() -> void:
	var _enable_collision = $PlayerArea.connect("area_entered", self, "enable_collision")
	var _disengage_grappling_hook = $PlayerArea.connect("area_entered", self, "disengage_grappling_hook")
	var _set_can_talk_true = $PlayerArea.connect("area_entered", self, "set_can_talk", [true])
	var _set_can_talk_false = $PlayerArea.connect("area_exited", self, "set_can_talk", [false])
	var _detected_poi = $PoiDetection.connect("area_entered", self, "detected_poi")
	var _poi_lost = $PoiDetection.connect("area_exited", self, "poi_lost")
	var _energyUpdate_charge = connect("energyUpdate_charge", get_parent().get_node("UI/UserInterface/ProgressBars"), "energyUpdate_charge")
	var _energyUpdate_drain = connect("energyUpdate_drain", get_parent().get_node("UI/UserInterface/ProgressBars"), "energyUpdate_drain")
#-------------------------------------------------------------------------------------------------#
#Applies Gravity
func apply_gravity(delta):
	motion.y += gravity * delta
#-------------------------------------------------------------------------------------------------#
#Handles Movement
func handle_movement() -> void:
	if grappling.is_grappling:
		handle_grapple_movement()
	else:
		handle_move_input()
#Handle Movement Input
func handle_move_input() -> void:
	old_move_dir = move_dir
	old_z_move_dir = z_move_dir
	
	move_dir = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	# Make a z_move_dir var, to determine if W or S are being pressed
	z_move_dir = -int(Input.is_action_pressed("move_forward")) + int(Input.is_action_pressed("move_backward"))
	
	# Accel/Decel
	if move_dir != 0:
		motion.x = lerp(motion.x, move_dir * max_speed, lerp(0.0, max_acceleration, acceleration_step))
	else:
		motion.x = lerp(motion.x, 0, lerp(0.0, friction, friction_step))
	
	if not is_falling:
		if z_move_dir != 0:
			motion.y = lerp(motion.y, z_move_dir * max_speed, lerp(0.0, max_acceleration, acceleration_step))
		else:
			motion.y = lerp(motion.y, 0, lerp(0.0, friction, friction_step))
#Handle Grappling Movement
func handle_grapple_movement() -> void:
	motion = lerp(motion, position.direction_to($GrapplingHook.grappling_point.global_position) * 100, lerp(0.0, 1.0, 0.15))
#Apply Movement
func apply_movement() -> void:
	motion = move_and_slide(motion, Vector2.UP)
#Disengage
func disengage_grappling_hook(_area: Area2D):
	grappling.is_grappling = false
	grappling.can_grapple = false
#Falling
#Set Flag
func set_is_falling(falling: bool) -> void:
	is_falling = falling
	if (falling):
		$CollisionShape2D.set_deferred("disabled", true)
#Disable Collision
func enable_collision(area: Area2D) -> void:
	if area.is_in_group("fall_end"):
		$CollisionShape2D.set_deferred("disabled", false)
func set_collision_disabled(disabled: bool):
	$CollisionShape2D.set_deferred("disabled", disabled)
#-------------------------------------------------------------------------------------------------#
#POI Interaction
func detected_poi(area: Area2D) -> void:
	emit_signal("detected_poi", area)

func poi_lost(area: Area2D) -> void:
	emit_signal("poi_lost", area)
	
func set_can_talk(area: Area2D, canTalk: bool) -> void:
	if area.is_in_group("dialog"):
		talking.can_talk = canTalk
#-------------------------------------------------------------------------------------------------#
#Energy
#Charge
func chargeEnergy(amount):
	set_energy(energy + amount)
#Drain
func drainEnergy(amount):
	if iFrameTimer.is_stopped():
		ouchieTimer.start()
		iFrameTimer.start()
		set_energy(energy - amount)
#Set Energy
func set_energy(value):
	var energy_prev = energy
	energy = clamp(value, 0, max_energy)
	if energy > energy_prev:
		emit_signal("energyUpdate_charge", energy)
	if energy < energy_prev:
		emit_signal("energyUpdate_drain", energy)
		if energy < 1:
			deactivate()
#HitBox
func _on_PlayerArea_area_entered(area: Area2D) -> void:
	match(area.name):
		"PU_Batteries": chargeEnergy(25)
		"PU_JumperCables": chargeEnergy(50)
		"HarshWeather": drainEnergy(5)
		"LightAttack": drainEnergy(15)
		"MediumAttack": drainEnergy(25)
		"HeavyAttack": drainEnergy(35)
		"InstaKill": drainEnergy(100)
#-------------------------------------------------------------------------------------------------#
#Deactivation
func deactivate():
	is_deactivating = true
	get_tree().root.get_node("Moon/YSort/UI/UserInterface").change_scene()
	

