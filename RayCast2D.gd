extends RayCast2D

var line2d : Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the Line2D node
	line2d = $Line2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the global mouse position
	var mouse_position = get_global_mouse_position()
	
	# Set the cast_to property of the RayCast2D to point towards the mouse position
	target_position = (mouse_position - global_position)
	# Update the points of the Line2D to visualize the raycast
	line2d.points[0] = position  # Start point at the origin of the RayCast2D
	line2d.points[1] = target_position  # End point at the position of the raycast collision point
	if Input.is_action_pressed("fire"):
		if is_colliding():
			get_collider().free()

		
