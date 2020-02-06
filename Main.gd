extends Spatial

func _input(_event):
	if Input.is_action_pressed("random"):
		$Environment.rotate_y(0.075)
	if Input.is_action_pressed("lighting"):
		$Environment/AnimationPlayer.playback_speed = 2
		yield(get_tree().create_timer(0.5), "timeout")
		$Environment/AnimationPlayer.playback_speed = 0.01
