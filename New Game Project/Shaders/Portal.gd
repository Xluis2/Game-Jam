extends MeshInstance

class_name CamPortal

export var current = false
export var  other_portal_path : NodePath

var other_portal: CamPortal = null

var helper: Spatial

func _ready():
	helper = $Helper
	if not  other_portal_path.is_empty():
		other_portal = get_node(other_portal_path)
	if current:
		$inside.visible = true

func _process(delta):
	pass
	if current:
		var main_cam = get_viewport().get_camera()
		helper.global_transform = main_cam.global_transform
		other_portal.helper.transform = helper.transform
		GlobalSettings.portal_camera.global_transform = other_portal.helper.global_transform
#		var diff = global_transform.origin - main_cam.helper.global_transform.origin
#		var angle = main_cam.global_transform.basis.z.angle_to(diff)
#		var near_plane = helper.transform.origin.length()*abs(cos(angle))
#		GlobalSettings.portal_camera.near = max(0.1, near_plane - 4.2)
		if not visible:
			visible =true
	
	else:
		if visible:
			visible = false
			


func _on_TransferArea_body_entered(body):
	if body.name != "Player":
		return
	if not current:
		current = true
		visible = true
	if current and $inside.visible:
		helper.global_transform = body.global_transform
		other_portal.helper.transform = helper.transform
		body.global_transform = other_portal.helper.global_transform
		#body.set_axis_velocity(body.target_velocity)
		current = false
		$inside.visible = false
		

func _on_InsideArea_body_exited(body):
	if body.name != "Player":
		return
	if current and not $inside.visible:
		$inside.visible = true 
