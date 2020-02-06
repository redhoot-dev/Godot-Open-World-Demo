 extends Spatial

func _input(event):
	if Input.is_action_pressed("random"):
		rotate_y(0.075)
