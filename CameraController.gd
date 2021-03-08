extends Camera

var move_speed = 10.0
var look_speed = 0.5
var mouse_delta = Vector2(0.0, 0.0)
var dt = 0.00 #TODO: get actual frametime
var invert_mouse_y = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func _calc_mouse_delta():
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event is InputEventMouseMotion:
		rotate(Vector3(0.0, 1.0, 0.0), -look_speed * dt * event.relative[0])
		if invert_mouse_y:
			rotate_object_local(Vector3(1.0, 0.0, 0.0), (look_speed * dt * event.relative[1]))
		else:
			rotate_object_local(Vector3(1.0, 0.0, 0.0), (-look_speed * dt * event.relative[1]))
			
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dt = delta
	var offset = Vector3(0.0, 0.0, 0.0)
	
	var s = move_speed
	if(Input.is_key_pressed((KEY_SHIFT))):
		s = move_speed * 5.0
	
	var m = s * dt
	if(Input.is_key_pressed(KEY_W)):
		offset += Vector3(0.0, 0.0, -m)
	if(Input.is_key_pressed(KEY_A)):
		offset += Vector3(-m, 0.0, 0.0)
	if(Input.is_key_pressed((KEY_S))):
		offset += Vector3(0.0, 0.0, m)
	if(Input.is_key_pressed((KEY_D))):
		offset += Vector3(m, 0.0, 0.0)
	if(Input.is_key_pressed((KEY_Q))):
		offset += Vector3(0.0, -m, 0.0)
	if(Input.is_key_pressed((KEY_E))):
		offset += Vector3(0.0, m, 0.0)
		
	# TODO: Probably need to transform this from local => world space
	#translate(offset)
	translate_object_local(offset)
