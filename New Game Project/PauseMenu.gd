extends ColorRect

onready var animator: AnimationPlayer = $AnimationPlayer
onready var playbtn: Button = find_node("Resume")
onready var quitbtn: Button = find_node("Quit")




func unpause():
	animator.play("Unpaused")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func pause():
	animator.play("Paused")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Resume_pressed():
	unpause()


func _on_Quit_pressed():
	get_tree().quit()
