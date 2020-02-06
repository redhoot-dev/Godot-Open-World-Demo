extends AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("TimeOfDay")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if Input.is_action_pressed("lighting"):
		set_speed_scale(2) 
		yield(get_tree().create_timer(0.5), "timeout")
		set_speed_scale(0.01) 
		
