extends Actor

var anchored: bool = true
var points_of_interest = []
var selected_poi = null

var num_of_ticks: int = 0
var float_range: float = 1
var float_offset: int = 0
var float_speed: float = 0.03

var alert = false

onready var rowbit = get_parent().get_node("Player")

func _ready() -> void:
	rowbit.connect("detected_poi", self, "detected_poi")
	rowbit.connect("poi_lost", self, "poi_lost")
	$AnimationPlayer.play("expo_bobble")

func _process(_delta: float) -> void:
	if (rowbit.grappling.can_grapple and has_arrived()) or rowbit.talking.can_talk:
		alert = true
	if not rowbit.grappling.can_grapple or not rowbit.talking.can_talk:
		alert = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("expo_tab") and points_of_interest.size() > 0:
		selected_poi = points_of_interest[(points_of_interest.find(selected_poi) + 1) % points_of_interest.size()]

func apply_bobble_movement() -> void:
	num_of_ticks += 1
	self.position.y = lerp(self.position.y, self.position.y + float_range * sin((num_of_ticks * float_speed) * PI) + float_offset, 0.25)

# Right now this is working by setting the global position... that's fine for now
# but would be better if we utilized a motion vector at some point
func apply_idle_movement() -> void:
	if self.position.distance_to(rowbit.get_node("ExpoAnchor").global_position) < 40:
		self.position = lerp(self.position, rowbit.get_node("ExpoAnchor").global_position, lerp(0, 0.1, 0.6))
	else:
		self.position = lerp(self.position, rowbit.get_node("ExpoAnchor").global_position, lerp(0, 0.075, 0.5))

func apply_hover_movement() -> void:
	self.position = lerp(self.position, selected_poi.global_position, lerp(0, 0.075, 1.0))

func has_arrived() -> bool:
	if self.position.distance_to(selected_poi.global_position) < 1:
		return true
	else:
		return false

func apply_movement() -> void:
	motion = move_and_slide(motion, Vector2.UP)

func handle_facing() -> void:
	if rowbit.move_dir < 0:
		$Sprite.flip_h = true
	if rowbit.move_dir > 0:
		$Sprite.flip_h = false

func detected_poi(area: Area2D) -> void:
	if area.is_in_group("POI"):
		anchored = false
		selected_poi = area
		points_of_interest.append(area)

func poi_lost(area: Area2D) -> void:
	if area.is_in_group("POI"):
		points_of_interest.erase(area)
		if points_of_interest.size() != 0:
			selected_poi = points_of_interest[0]
		else:
			anchored = true
			set_deferred("selected_poi", null)
