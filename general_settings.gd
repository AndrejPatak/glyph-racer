extends Node2D

@export_range(0.0, 1.0, .1) var music_volume : float = 0.8
@export_range(0.0, 1.0, .1) var effects_volume : float = 0.8

@export_file var settingsFile : String
var settings : FileAccess

@export var graphics_quality : String = "good"

func _ready() -> void:
	load_settings()

func save_settings() -> void:
	settings = FileAccess.open(settingsFile, FileAccess.WRITE)
	var settingsString : String = ""
	settingsString += "music=" + str(Settings.get_volume("music")) + "\n"
	settingsString += "effects=" + str(Settings.get_volume("effects")) + "\n"
	settingsString += "graphics=" + "mid" + "\n"
	settingsString += "fps=" + str(Engine.max_fps) + "\n"
	settings.store_string(settingsString)
	settings.flush()
	settings.close()

func load_settings() -> void:
	settings = FileAccess.open(settingsFile, FileAccess.READ)
	while (!settings.eof_reached()):
		var line : String = settings.get_line()
		if line != "":
			var lines := line.split("=")
			match lines[0]:
				"music":
					Settings.set_volume("music", float(lines[1]))
				"effects":
					Settings.set_volume("effects", float(lines[1]))
				"fps":
					pass
				"graphics":
					pass
				_:
					printerr("Setting not recognized: ", lines[0])
	settings.close()
	for effect in get_tree().get_nodes_in_group("sound_effect"):
		effect.volume_db = -50 / (Settings.effects_volume * 5) + 10

func set_volume(forWhat : String, toWhat : float = 0.7) -> void:
	match forWhat:
		"music":
			music_volume = toWhat
			Music.setVolume(music_volume)
		"effects":
			effects_volume = toWhat
			for effect in get_tree().get_nodes_in_group("sound_effect"):
				print("Setting the volume for ", effect.name, " to: ", toWhat)
				effect.volume_db = -50 / (toWhat * 5) + 10
		_:
			printerr("Unknown sound type: ", forWhat, "; Recieved value: ", toWhat)

func get_volume(forWhat : String) -> float:
	match forWhat:
		"music":
			return music_volume
		"effects":
			return effects_volume
		_:
			printerr("Unknown sound type: ", forWhat)
			return -1

func _input(event):
	if event.is_action_pressed("menu_back"):
		match TimeTracker.prevMenu:
			"main":
				get_tree().change_scene_to_file("res://main_menu.tscn")
			_:
				printerr("Unhandled back to menu: ", TimeTracker.prevMenu)
