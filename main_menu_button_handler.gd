extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Continue.disabled = not TimeTracker.checkContiue()
	if %Continue.disabled:
		%NewGame.grab_focus()
		%Highlight.setup(%NewGame)
	else:
		%Continue.grab_focus()
		%Highlight.setup(%Continue)
		
	#print("co: ", %Continue.disabled)
	
	
func _on_new_game_pressed() -> void:
	TimeTracker.resetTimes()
	get_tree().change_scene_to_file("res://track_select.tscn")

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://track_select.tscn")

func _on_settings_pressed() -> void:
	TimeTracker.prevMenu = "main"
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_quit_pressed() -> void:
	TimeTracker.save_times()
	get_tree().quit()
