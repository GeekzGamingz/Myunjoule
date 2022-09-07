extends YSort
#------------------------------------------------------------------------------#
#Area Signals
#Ground Entered
func _on_Ground_body_entered(body: Node) -> void:
	if body.z_index == 30:
		match(body.name):
			"Player":
				body.story = "GROUND"
				body.z_index = 0
#Ground Exited
func _on_Ground_body_exited(body: Node) -> void:
	if body.z_index == 0:
		match(body.name):
			"Player":
				body.story = "FALLING"
				body.z_index = 30
#Story 1 Entered
func _on_Story1_body_entered(body: Node) -> void:
	if body.z_index == 30:
		match(body.name):
			"Player":
				body.story = "STORY1"
				body.z_index = 10
#Story 1 Exited
func _on_Story1_body_exited(body: Node) -> void:
	if body.z_index == 10:
		match(body.name):
			"Player":
				body.story = "FALLING"
				body.z_index = 30
func _on_Story2_body_entered(body: Node) -> void:
	if body.z_index == 30:
		match(body.name):
			"Player":
				body.story = "STORY2"
				body.z_index = 20
#Story 1 Exited
func _on_Story2_body_exited(body: Node) -> void:
	if body.z_index == 20:
		match(body.name):
			"Player":
				body.story = "FALLING"
				body.z_index = 30
