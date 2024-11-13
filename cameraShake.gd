extends Camera2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("dbg_rotate_cam_minus"):
		self.rotation_degrees -= 10
	if Input.is_action_just_pressed("dbg_rotate_cam_plus"):
		self.rotation_degrees += 10
