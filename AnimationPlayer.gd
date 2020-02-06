extends AnimationPlayer

func _input(event):
	if Input.is_action_pressed("lighting"):
		playback_speed = 2
		yield(get_tree().create_timer(0.5), "timeout")
		playback_speed = 0.01
