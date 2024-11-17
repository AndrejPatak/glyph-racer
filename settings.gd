extends Control




func _ready() -> void:
	load_settings()
	modulate = Colorizer.get_color("track")
	


func load_settings() -> void:
	update_music()
	update_effects()
	%fps_label.text = str(Engine.max_fps)
	%graphics_button.text = Settings.graphics_quality.to_upper()

func _on_music_value_changed(value: float) -> void:
	Settings.set_volume("music", value)
	update_music()

func _on_effects_value_changed(value: float) -> void:
	Settings.set_volume("effects", value)
	update_effects()

func update_music() -> void:
	%music_label.text = str(Settings.music_volume * 10)
	%music_slider.value = Settings.music_volume
	
func update_effects() -> void:
	%effects_label.text = str(Settings.effects_volume * 10)
	%effects_slider.value = Settings.effects_volume
	

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
			Settings.set_graphics("mid")
		"mid":
			Settings.set_graphics("good")
		_:
			printerr("Graphics button error in settings.gd")
	
	%graphics_button.text = Settings.graphics_quality.to_upper()
		
