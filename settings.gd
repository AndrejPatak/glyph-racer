extends Control




func _ready() -> void:
	load_settings()
	modulate = Colorizer.get_color("track")


func load_settings() -> void:
	%music_label.text = str(Settings.music_volume)
	%effects_label.text = str(Settings.effects_volume)
	%fps_label.text = str(Engine.max_fps)
	%graphics_button.text = Settings.graphics_quality.to_upper()

func _on_music_value_changed(value: float) -> void:
	Settings.set_volume("music", value)
	%music_label.text = str(value * 10)

func _on_effects_value_changed(value: float) -> void:
	Settings.set_volume("effects", value)
	%effects_label.text = str(value * 10)


func _on_fps_value_changed(value: float) -> void:
	match value:
		0.0:
			Engine.max_fps = 30
		1.0:
			Engine.max_fps = 45
		2.0:
			Engine.max_fps = 60
		3.0:
			Engine.max_fps = 144
		4.0:
			Engine.max_fps = 999
		_:
			printerr("Unhandled fps value: ", value)
	%fps_label.text = str(Engine.max_fps)

func _on_back_pressed() -> void:
	match TimeTracker.prevMenu:
		"main":
			get_tree().change_scene_to_file("res://main_menu.tscn")
		"pause":
			self.queue_free()
		_:
			printerr("Unknown prev menu: ", TimeTracker.prevMenu)


func _on_save_pressed() -> void:
	Settings.save_settings()


func _on_graphics_button_pressed() -> void:
	match Settings.graphics_quality:
		"good":
			Settings.graphics_quality = "mid"
		"mid":
			Settings.graphics_quality = "good"
		_:
			printerr("Graphics button error in settings.gd")
	%graphics_button.text = Settings.graphics_quality.to_upper()
		
