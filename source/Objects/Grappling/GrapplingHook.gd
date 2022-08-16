extends Area2D

var grappling_point = null
# Maybe some tie in to the drone and POI system?

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", self, "prime_hook")
	connect("area_exited", self, "disengage_hook")

func prime_hook(area: Area2D):
	if area.is_in_group("grappling_point"):
		grappling_point = area
		get_parent().grappling.can_grapple = true

func disengage_hook(area: Area2D):
	if area.is_in_group("grappling_point"):
		grappling_point = null
		get_parent().grappling.can_grapple = false
