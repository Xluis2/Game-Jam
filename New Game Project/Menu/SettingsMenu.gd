extends Popup


onready var display_options_btn = $MainMenu2/SettingsContainer/VideoSettings/OptionButton2
onready var vsync_btn = $MainMenu2/SettingsContainer/VideoSettings/CheckButton
onready var fullscreen_btn = $MainMenu2/SettingsContainer/VideoSettings/CheckBox


onready var master_slider = $MainMenu2/SettingsContainer/AudioSettings/mastervol
onready var music_slider = $MainMenu2/SettingsContainer/AudioSettings/Music_vol
onready var sfx_slider = $MainMenu2/SettingsContainer/AudioSettings/sfx_vol2

onready var mouse_sens_slider = $MainMenu2/SettingsContainer/ControlsSettings/Mouse
onready var mouse_sens_val = $MainMenu2/SettingsContainer/ControlsSettings/Mouse_sens_val


func _ready():
	pass
	




func _on_OptionButton2_item_selected(index):
	pass # Replace with function body.


func _on_CheckButton_toggled(button_pressed):
	pass # Replace with function body.

#fullscreen
func _on_CheckBox_toggled(button_pressed):
	pass # Replace with function body.
