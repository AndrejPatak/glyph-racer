extends Control

@export var settingsFile : String

func _ready() -> void:
	if settingsFile == "":
		print("No settings file set.")
	load_settings()

func save_settings() -> void:
	pass

func load_settings() -> void:
	pass

func _on_music_value_changed(value: float) -> void:
	SoundSettings.set_volume("music", value)
	%music_label.text = str(value * 10)

func _on_effects_value_changed(value: float) -> void:
	SoundSettings.set_volume("effects", value)
	%effects_label.text = str(value * 10)


func _on_fps_value_changed(value: float) -> void:
	pass


func _on_back_pressed() -> void:
	match TimeTracker.prevMenu:
		"main":
			get_tree().change_scene_to_file("res://main_menu.tscn")
		"pause":
			self.queue_free()
		_:
			printerr("Unknown prev menu: ", TimeTracker.prevMenu)


func _on_save_pressed() -> void:
	save_settings()
