extends Node

const SAVEFILE = "user://SAVEFILE.save"
onready var Player = "res://Player.tscn"

var game_data = {}

var SAVE_DIR = "user://save/"
var SAVE_FILE = "user://save/game_data.save"


func _ready():
	load_data()
	load_save()
	autosave()

func _process(delta):
	if Input.is_action_just_pressed("E"):
		load_save()


func load_data():	
	var file = File.new()
	if not file.file_exists(SAVEFILE):
		game_data = {
			"fullscreen_on": true,
			"vsync_on": false,
			"display_fps": false,
			"max_fps": 0,
			"master_vol": -10,
			"music_vol": -10,
			"sfx_vol": -10,
			"mouse_sens": .1,
		}
		save_data()
	file.open(SAVEFILE, File.READ)
	game_data = file.get_var()
	file.close()

func save_data():
	var file = File.new()
	file.open(SAVEFILE, File.WRITE)
	file.store_var(game_data)
	file.close()

func save_game_data():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir(SAVE_DIR)
	
	var save_game = File.new()
	save_game.open(str(SAVE_FILE), File.WRITE)
	var save_data = {}
	#todo: Save the Player Data and position, which also the puzzle phase
	
	var find_saveable_nodes = get_tree().get_nodes_in_group("saveable")
	for saveable in find_saveable_nodes:
		if !saveable.has_method("save"):
			print("Saveable node is missing a save() function.")
			continue
		
		save_data[saveable.name] = saveable.call("save")
	
	
	var data_string = var2str(save_data)
	save_game.store_string(data_string)
	save_game.close()
	
	
	
func load_save():
	var save_game = File.new()
	if !save_game.file_exists(str(SAVE_FILE)):
		print("No Save File Detected, ")
		return
	
	save_game.open(str(SAVE_FILE), File.READ)
	var data_string = save_game.get_as_text()
	var save_data : Dictionary = str2var(data_string)
	
	if save_data.has("Player"):
#		Player.load_save(save_data["Player"])
		print("saved")
	print(save_data)
	save_game.close()
	
	
#original is 480
func autosave():
	yield(get_tree().create_timer(5.0), "timeout")
	save_game_data()
	print("1")
	autosave2()
	return


func autosave2():
	yield(get_tree().create_timer(5.0), "timeout")
	save_game_data()
	print("1")
	autosave()
	return
