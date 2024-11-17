extends Control


func _ready() -> void:
	%tryAgain.grab_focus()
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("focus_entered", shiftHighlight.bind(button))
	modulate = Colorizer.get_color("danger")
func shiftHighlight(button) -> void:
	%Highlight.reparent(button.get_parent())


func _on_try_again_pressed() -> void:
	TimeTracker.unpause()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")


func _on_play_another_pressed() -> void:
	get_tree().change_scene_to_file("res://track_select.tscn")


func _on_play_next_pressed() -> void:
	TimeTracker.curTrackID += 1
	TimeTracker.currentTrack = "track_" + str(TimeTracker.curTrackID)
	TimeTracker.unpause()
	get_tree().change_scene_to_file("res://world.tscn")


func _on_save_game_pressed() -> void:
	TimeTracker.save_times()
