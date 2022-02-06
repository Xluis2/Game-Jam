extends Popup


onready var display_options_btn = $MainMenu2/SettingsContainer/VideoSettings/OptionButton2
onready var vsync_btn = $MainMenu2/SettingsContainer/VideoSettings/CheckButton
onready var fullscreen_btn = $MainMenu2/SettingsContainer/VideoSettings/CheckBox


onready var master_slider = $MainMenu2/SettingsContainer/AudioSettings/HSlider
onready var music_slider = $MainMenu2/SettingsContainer/AudioSettings/HSlider2
onready var sfx_slider = $MainMenu2/SettingsContainer/AudioSettings/HSlider3

onready var mouse_sens_slider = $MainMenu2/SettingsContainer/ControlsSettings/HSlider
onready var mouse_sens_val = $MainMenu2/SettingsContainer/ControlsSettings/Mouse_sens_val


func _ready():
	display_options_btn.select(1 if Save.game_data.fullscreen_on else 0)
	GlobalSettings.toggle_fullscreen(Save.game_data.fullscreen_on)
	vsync_btn.pressed = Save.game_data.vsync_on
	
	master_slider.value = Save.game_data.master_vol
	music_slider.value = Save.game_data.music_vol
	sfx_slider.value = Save.game_data.sfx_vol
	
	mouse_sens_slider.value = Save.game_data.mouse_sens


func _on_OptionButton2_item_selected(index):
	GlobalSettings.toggle_fullscreen(true if index == 1 else false)


func _on_CheckButton_toggled(button_pressed):
	GlobalSettings.toggle_vsync(button_pressed)


func _on_HSlider_value_changed(value):
	GlobalSettings.update_master_vol(value)


func _on_HSlider2_value_changed(value):
	GlobalSettings.update_music_vol(value)


func _on_HSlider3_value_changed(value):
	GlobalSettings.update_sfx_vol(value)


func _on_Mouse_sens_value_changed(value):
	GlobalSettings.update_mouse_sens(value)
	mouse_sens_val.text = str(value)
