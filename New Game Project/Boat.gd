extends RigidBody

var mouse_movement = Vector2()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement += event.relative


func _physics_process(delta):
	if mouse_movement != Vector2():
		$H.rotation_degrees.y += -mouse_movement.x
		$H/V.rotation_degrees.x += -mouse_movement.y
		mouse_movement = Vector2()
