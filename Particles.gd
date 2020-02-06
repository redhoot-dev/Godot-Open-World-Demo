extends Particles

export var rows = 20 setget set_rows, get_rows
export var spacing = 1.0 setget set_spacing, get_spacing

func update_aabb():
	var size = rows * spacing;
	visibility_aabb = AABB(Vector3(-0.5 * size, 0.0, -0.5 * size), Vector3(size, 800, size))

func set_rows(new_rows):
	rows = new_rows
	amount = rows * rows
	update_aabb()
	if process_material:
		process_material.set_shader_param("rows", rows)

	
func get_rows():
	return rows

func set_spacing(new_spacing):
	spacing = new_spacing
	update_aabb()
	if process_material:
		process_material.set_shader_param("spacing", spacing)

func get_spacing():
	return spacing


# Called when the node enters the scene tree for the first time.
func _ready():
	set_rows(rows)
	
func _process(delta):
	
	var viewport = get_viewport()
	var camera = viewport.get_camera()

	var pos = camera.global_transform.origin
	pos.y = 0.0
	global_transform.origin = pos
	
	
