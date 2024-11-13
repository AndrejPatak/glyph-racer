extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TimeTracker.reset_ui_layer()
	TimeTracker.load_times()
	for button in get_tree().get_nodes_in_group("track_button"):
		button.connect("pressed", handle_button.bind(button.name))
	#print("Loaded")
	TimeTracker.unpause()
	%track_1_button.grab_focus()

func handle_button(button) -> void:
	match button:
		"track_1_button":
			TimeTracker.currentTrack = "track_1"
		"track_2_button":
			TimeTracker.currentTrack = "track_2"
		"track_3_button":
			TimeTracker.currentTrack = "track_3"
		"track_4_button":
			TimeTracker.currentTrack = "track_4"
		"track_5_button":
			TimeTracker.currentTrack = "track_5"
		"track_6_button":
			TimeTracker.currentTrack = "track_6"
		"track_7_button":
			TimeTracker.currentTrack = "track_7"
		_:
			print("ntn happen: ", button)
	#print(TimeTracker.currentTrack)
	get_tree().change_scene_to_file("res://world.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_save_and_exit_pressed() -> void:
	TimeTracker.save_times()
	get_tree().quit()
