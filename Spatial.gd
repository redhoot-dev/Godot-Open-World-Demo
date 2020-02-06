extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("TimeOfDay")

	pass # Replace with function body.


func _input(event):
	if Input.is_action_pressed("random"):
		# print("yepppps...")
		rotate_y(0.075)
		# var temp_angle = rand_range(-1,-1)
		# $lightSun.rotate_object_local(Vector3(1,0,0),1)
		# print(temp_angle)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#rotate_y(delta*0.01)
#	pass
