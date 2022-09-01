extends Position2D
#------------------------------------------------------------------------------#
#Constants
const SPEED = 10
#Variables
var direction = Vector2.ZERO
var tipPOS = Vector2.ZERO
#Bool Variables
var flying: bool = false
var hooked: bool = false
#OnReady Variables
onready var links: Sprite = $Links
onready var tip: KinematicBody2D = $Tip
#------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	tipPOS = get_parent().global_position
#------------------------------------------------------------------------------#
#Processes
#Standard Process
func _process(_delta: float) -> void:
	self.visible = flying || hooked
	if !self.visible:
		return
	var tip_loc = to_local(tipPOS)
	#Link Rotation
	links.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	tip.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	links.position = tip_loc
	links.region_rect.size.y = tip_loc.length()
#Physics Process
func _physics_process(_delta: float) -> void:
	tip.global_position = tipPOS
	if flying && tip.move_and_collide(direction * SPEED):
		hooked = true
		flying = false
	tipPOS = tip.global_position
#------------------------------------------------------------------------------#
#Shoot Grappling Hook
func grapple_shoot(dir: Vector2) -> void:
	tipPOS = G.PLAYER.get_node("Anchors").global_position
	direction = (dir - tipPOS).normalized()
	flying = true
	tipPOS = self.global_position
	G.PLAYER.target.get_parent().node_b = G.PLAYER.get_path()
#Release Grappling Hook
func grapple_release() -> void:
	tipPOS = get_parent().global_position
	flying = false
	hooked = false
