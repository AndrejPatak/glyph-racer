extends Control

var dialogueFile : PackedScene = preload("res://dialogue.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TimeTracker.reset_ui_layer()
	TimeTracker.load_times()
	for button in get_tree().get_nodes_in_group("track_button"):
		button.connect("pressed", handle_button.bind(button.name))
	#print("Loaded")
	TimeTracker.unpause()
	%track_1_button.grab_focus()
	
	modulate = Colorizer.get_color("player")
	
	if TimeTracker.currentTrack == "track_8":
		triggerDialogue(["You did it!!", "You escaped!", "I guess we won't see eachother again.", "Farewell, then... let the cyberspace be kind to you."])
	

func handle_button(button) -> void:
	match button:
		"track_1_button":
			TimeTracker.currentTrack = "track_1"
			TimeTracker.curTrackID = 1
		"track_2_button":
			TimeTracker.currentTrack = "track_2"
			TimeTracker.curTrackID = 2
		"track_3_button":
			TimeTracker.currentTrack = "track_3"
			TimeTracker.curTrackID = 3
		"track_4_button":
			TimeTracker.currentTrack = "track_4"
			TimeTracker.curTrackID = 4
		"track_5_button":
			TimeTracker.currentTrack = "track_5"
			TimeTracker.curTrackID = 5
		"track_6_button":
			TimeTracker.currentTrack = "track_6"
			TimeTracker.curTrackID = 6
		"track_7_button":
			TimeTracker.currentTrack = "track_7"
			TimeTracker.curTrackID = 7
		"track_8_button":
			TimeTracker.currentTrack = "track_8"
			TimeTracker.curTrackID = 8
		_:
			print("ntn happen: ", button)
	#print(TimeTracker.currentTrack)
	get_tree().change_scene_to_file("res://world.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_save_and_exit_pressed() -> void:
	TimeTracker.save_times()
	get_tree().quit()

func triggerDialogue(text : Array[String]) -> void:
	var dialogueNode : PanelContainer = dialogueFile.instantiate()
	dialogueNode.set_dialogs(text)
	#dialogueNode.modulate = Colorizer.get_color("danger")
	dialogueNode.modulate = Color.WHITE
	add_child(dialogueNode)
	dialogueNode.modulate = Color.WHITE
	dialogueNode.process_mode = Node.PROCESS_MODE_ALWAYS


func disable_song_control() -> void:
	print("Mouse entered")
	Music.disable_controls()

func enable_song_control() -> void:
	print("Mouse exited")
	Music.enable_controls()
