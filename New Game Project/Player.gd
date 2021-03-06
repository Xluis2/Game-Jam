extends KinematicBody

var speed = 7
const ACCEL_DEFAULT = 7
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 12
var jump = 6

var cam_accel = 40
var mouse_sense = 0.1
var snap

var progress = 1

var able_to_move = true

signal Puzzlefound

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

onready var head = $Head
onready var camera = $Head/Camera

func _ready():
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GlobalSettings.connect("mouse_sens_updated", self, "_on_mouse_sense_updated")
	GlobalSettings.portal_camera = $PortalViewport/PortalCamera

func _input(event):
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _process(delta):
	#camera physics interpolation to reduce physics jitter on high refresh-rate monitors
	if Engine.get_frames_per_second() > Engine.iterations_per_second:
		camera.set_as_toplevel(true)
		camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(head.global_transform.origin, cam_accel * delta)
		camera.rotation.y = rotation.y
		camera.rotation.x = head.rotation.x
	else:
		camera.set_as_toplevel(false)
		camera.global_transform = head.global_transform
	pass
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		$Head/PauseMenu.pause()
	
	
func _physics_process(delta):
	progress += 1 * delta
	var position = global_transform.basis
	#get keyboard input
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("back") - Input.get_action_strength("forward")
	var h_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	if able_to_move:
		direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	
	#jumping and gravity
	if is_on_floor():
		snap = -get_floor_normal()
		accel = ACCEL_DEFAULT
		gravity_vec = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		accel = ACCEL_AIR
		gravity_vec += Vector3.DOWN * gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap = Vector3.ZERO
		gravity_vec = Vector3.UP * jump
	
	
	
	
	
	#make it move
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
	move_and_slide_with_snap(movement, snap, Vector3.UP)
	
	
func _on_mouse_sense_updated(value):
	mouse_sense = value

func save():
	return {
		"progress" : progress,
		"pos_x" : global_transform.origin.x,
		"pos_y" : global_transform.origin.y,
		"pos_z" : global_transform.origin.z,
	}


func load_save(data):
	if not data:
		return
		
	
	progress = data["progress"]
	global_transform.origin.x = data["pos_x"]
	global_transform.origin.y = data["pos_y"]
	global_transform.origin.z = data["pos_z"]
	



func _on_Area_area_entered(area):
	var collider = area
	if collider.is_in_group("Water"):
		print("Touching water")
