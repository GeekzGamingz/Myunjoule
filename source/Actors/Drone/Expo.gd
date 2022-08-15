extends Actor

export(float, 0, 1, 0.01) var anchor_follow_weight = 0.25

var anchored: bool = true
var points_of_interest = []
var selected_poi = null

var num_of_ticks: int = 0
var float_range: float = 1
var float_offset: int = 0
var float_speed: float = 0.03

onready var rowbit = get_parent().get_node("Player")

func _ready() -> void:
	$PoiDetection.connect("area_entered", self, "detected_poi")
	$PoiDetection.connect("area_exited", self, "poi_left_range")
	$PlayerDetection.connect("body_exited", self, "player_left_range")
	$AnimationPlayer.play("expo_bobble")

func apply_bobble_movement() -> void:
	num_of_ticks += 1
	self.position.y = lerp(self.position.y, self.position.y + float_range * sin((num_of_ticks * float_speed) * PI) + float_offset, 0.25)

func apply_idle_movement() -> void:
	if self.position.distance_to(rowbit.get_node("ExpoAnchor").global_position) < 40:
		self.position = lerp(self.position, rowbit.get_node("ExpoAnchor").global_position, anchor_follow_weight)
	else:
		self.position = lerp(self.position, rowbit.get_node("ExpoAnchor").global_position, lerp(0, 0.075, 1.0))

func apply_hover_movement() -> void:
	self.position = lerp(self.position, selected_poi.global_position, lerp(0, 0.075, 1.0))

func apply_movement() -> void:
	motion = move_and_slide(motion, Vector2.UP)

func handle_facing() -> void:
	if rowbit.move_dir < 0:
		$Sprite.flip_h = true
	if rowbit.move_dir > 0:
		$Sprite.flip_h = false

func detected_poi(area: Area2D) -> void:
	if area.name == "GrapplingPoint":
		anchored = false
		# Setting the selected POI here just for now
		selected_poi = area
		points_of_interest.append(area)

func poi_left_range(area: Area2D) -> void:
	if area.is_in_group("POI"):
		points_of_interest.erase(area)
		if points_of_interest.size() != 0:
			selected_poi = points_of_interest[0]
		else:
			anchored = true
			set_deferred("selected_poi", null)

func player_left_range(body: Node):
	if body.name == "Player":
		anchored = true
