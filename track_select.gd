extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TimeTracker.load_times()
	for button in get_tree().get_nodes_in_group("track_button"):
		button.connect("pressed", handle_button.bind(button.name))
	print("Loaded")
	TimeTracker.unpause()

func handle_button(button) -> void:
	match button:
		"track_1_button":
			TimeTracker.currentTrack = "track_1"
			
		"track_2_button":
			TimeTracker.currentTrack = "track_2"
		"track_3_button":
			pass
		"track_4_button":
			pass
		"track_5_button":
			pass
		"track_6_button":
			pass
		_:
			print("ntn happen: ", button)
	print(TimeTracker.currentTrack)
	get_tree().change_scene_to_file("res://world.tscn")
