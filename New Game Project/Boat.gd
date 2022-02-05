extends RigidBody

var mouse_movement = Vector2()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement += event.relative

var acceleration : int
var speed = 20

func _physics_process(delta):
	if mouse_movement != Vector2():
		mouse_movement *= 0.1
		$H.rotation_degrees.y += -mouse_movement.x
		$H/V.rotation_degrees.x += -mouse_movement.y
		if $H/V.rotation_degrees.x <= -30:
			$H/V.rotation_degrees.x = -30
		if $H/V.rotation_degrees.x >= 0:
			$H/V.rotation_degrees.x = 0
		mouse_movement = Vector2()


	if global_transform.origin.y <= 0.1:
		if Input.is_action_pressed("forward"):
			add_central_force(global_transform.basis.xform(Vector3.FORWARD*speed))
			if Input.is_action_pressed("left"):
				add_torque(Vector3(0, 3, 0))
			if Input.is_action_pressed("right"):
				add_torque(Vector3(0, -3, 0	))
		elif Input.is_action_pressed("back"):
			add_central_force(global_transform.basis.xform(Vector3.BACK*5))
			if Input.is_action_pressed("left"):
				add_torque(Vector3(0, 2, 0))
			if Input.is_action_pressed("right"):
				add_torque(Vector3(0, -2, 0))
	
	
	if $Floaty.global_transform.origin.y <= 0:
		add_force(Vector3.UP*20*-$Floaty.global_transform.origin, $Floaty.global_transform.origin-global_transform.origin)
	if $Floaty2.global_transform.origin.y <= 0:
		add_force(Vector3.UP*20*-$Floaty2.global_transform.origin, $Floaty2.global_transform.origin-global_transform.origin)
	if $Floaty3.global_transform.origin.y <= 0:
		add_force(Vector3.UP*20*-$Floaty3.global_transform.origin, $Floaty3.global_transform.origin-global_transform.origin)
	if $Floaty4.global_transform.origin.y <= 0:
		add_force(Vector3.UP*20*-$Floaty4.global_transform.origin, $Floaty4.global_transform.origin-global_transform.origin)

