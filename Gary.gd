# This script was made with the generous help of Jeremy Bullock following his 
# tutorial on creating a first person camera controller.
#
# This is severly basterdized, I recommend following his original video here :
# https://www.youtube.com/channel/UCwJw2-V5S1TkBjLQ3_Ws54g/featured
#
#

extends KinematicBody

var camera_angle = 0
var mouse_sensitivity = 0.1

var velocity = Vector3()
var direction = Vector3()

# Fly vars
const FLY_SPEED = 5
const FLY_ACCEL = 1

# Walk vars
var gravity = -29.8
const MAX_SPEED = 4
const MAX_RUNNING_SPEED = 12
const ACCEL = 10
const DEACCEL = 10

var playerMode = 0
var zoommode = 1
# Jump
var jump_height = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	playerMode = 1
	pass


func _physics_process(delta):
	if playerMode == 0:
		fly(delta)
	if playerMode == 1:
		walk(delta)
	
	
	# if $Head/RayCast.is_colliding():
	# print($Head/RayCast.get_collision_point())
	

	

	
func _input(event):
	if event is InputEventMouseMotion:
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var change = -event.relative.y * mouse_sensitivity
		if change + camera_angle < 90 and change + camera_angle > -90:
				$Head/Camera.rotate_x(deg2rad(change))
				camera_angle += change
	
	if Input.is_action_pressed("switch"):
		if playerMode == 0:
			playerMode = 1
		else:
			playerMode = 0		
			
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		
	
	
		
	if Input.is_action_just_pressed("zoom"):
		if zoommode == 1:
			zoommode = 0
			$Head/Camera.set("fov",20)
			mouse_sensitivity = 0.05
			
		else:
			zoommode = 1		
			$Head/Camera.set("fov",70)
			mouse_sensitivity = 0.2

func walk(delta):
		# reset the direction of the player
	direction = Vector3()
	
	# get the local rotation of camera
	var aim = $Head/Camera.get_global_transform().basis
	
	# check iunut and change dir
	if Input.is_action_pressed("move_forward"):
			direction -= aim.z
	if Input.is_action_pressed("move_backward"):
			direction += aim.z
	if Input.is_action_pressed("move_left"):
			direction -= aim.x
	if Input.is_action_pressed("move_right"):
			direction += aim.x
	if Input.is_action_pressed("move_up"):
			direction += aim.y * 0.1
	if Input.is_action_pressed("move_down"):
			direction -= aim.y * 0.1
	

	
	
	direction = direction.normalized()
	
	velocity.y += gravity * delta
	
	var temp_velocity = velocity 
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("move_sprint"):
		speed = MAX_RUNNING_SPEED
	else:
		speed = MAX_SPEED
	
	# where would hthe player go at max speed
	var target = direction * speed
	
	var acceleration
	if direction.dot(temp_velocity) > 0:
		acceleration = ACCEL
	else:
		acceleration = DEACCEL
		

	# calculate a portion of the distance to go
	temp_velocity = temp_velocity.linear_interpolate(target, ACCEL * delta)

	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_height

	# move 
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	




func fly(delta):
		# reset the direction of the player
	direction = Vector3()
	
	# get the local rotation of camera
	var aim = $Head/Camera.get_global_transform().basis
	
	# check iunut and change dir
	if Input.is_action_pressed("move_forward"):
			direction -= aim.z
	if Input.is_action_pressed("move_backward"):
			direction += aim.z
	if Input.is_action_pressed("move_left"):
			direction -= aim.x
	if Input.is_action_pressed("move_right"):
			direction += aim.x
	if Input.is_action_pressed("move_up"):
			direction += aim.y * 0.1
	if Input.is_action_pressed("move_down"):
			direction -= aim.y * 0.1
	direction = direction.normalized()
	
	var target
	# where would hthe player go at max speed
	if Input.is_action_pressed("move_sprint"):
		target = direction * FLY_SPEED * 12
	else:
		target = direction * FLY_SPEED
	
	# calculate a portion of the distance to go
	velocity = velocity.linear_interpolate(target, FLY_ACCEL * delta)

	# move 
	move_and_slide(velocity)
	
