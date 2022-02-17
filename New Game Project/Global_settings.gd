extends Node

signal mouse_sens_updated(value)

func toggle_fullscreen(value):
	OS.window_fullscreen = value
	Save.game_data.fullscreen_on = value
	Save.save_data()

func toggle_vsync(value):
	OS.vsync_enabled = value
	Save.game_data.vsync_on = value
	Save.save_data()

func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)
	Save.game_data.master_vol = vol
	Save.save_data()

func update_music_vol(vol):
	AudioServer.set_bus_volume_db(1, vol)
	Save.game_data.music_vol = vol
	Save.save_data()



func update_sfx_vol(vol):
	AudioServer.set_bus_volume_db(2, vol)
	Save.game_data.sfx_vol = vol
	Save.save_data()

func update_mouse_sens(value):
	emit_signal("mouse_sens_updated", value)
	Save.game_data.mouse_sens = value
	Save.save_data()

