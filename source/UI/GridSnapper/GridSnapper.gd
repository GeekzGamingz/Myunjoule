extends Position2D

var grid_size = Vector2()
var grid_position = Vector2()

onready var parent = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	grid_size = get_camera_size()
	set_as_toplevel(true)
	update_grid_position()

func _physics_process(delta):
	update_grid_position()

# Move along the grid.
func update_grid_position():
	# Check to make sure that the grid size is the same as what the camera can see.
	if grid_size != get_camera_size():
		grid_size = get_camera_size()
	
	# Get the new grid position for this frame...
	var x = round(parent.position.x / grid_size.x)
	var y = round(parent.position.y / grid_size.y)
	var new_grid_position = Vector2(x, y)
	
	# If the new grid position for the frame is the same as the current grid position, do nothing.
	if grid_position == new_grid_position:
		return
	
	# Update the grid position if they are not the same and move the camera to the new grid cell.
	grid_position = new_grid_position
	self.position = grid_position * grid_size

# Return the current size of what the camera can see.
func get_camera_size():
	return get_viewport().size * $MainCamera.zoom
