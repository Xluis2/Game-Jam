extends Camera


export var main_cam_path: NodePath

var main_cam: Camera

func _ready():
	main_cam = get_node(main_cam_path)
	
func _process(delta):
	global_transform = main_cam.global_transform
