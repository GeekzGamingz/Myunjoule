extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", self, "show_grapple_button")
	connect("area_exited", self, "hide_grapple_button")
	connect("area_entered", self, "recently_used")

func show_grapple_button(area: Area2D) -> void:
	if area.name == "GrapplingHook":
		$Label.visible = true

func hide_grapple_button(area: Area2D) -> void:
	if area.name == "GrapplingHook":
		$Label.visible = false

func recently_used(area: Area2D):
	if area.name == "PlayerArea":
		$Label.visible = false