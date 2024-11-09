extends Control

func _ready() -> void:
	%Continue.grab_focus()
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("focus_entered", shiftHighlight.bind(button))

func _on_save_pressed() -> void:
	TimeTracker.save_times()

func _on_quit_pressed() -> void:
	TimeTracker.save_times()
	TimeTracker.quit_game()

func _on_exit_race_pressed() -> void:
	get_tree().change_scene_to_file("res://track_select.tscn")

func _on_restart_pressed() -> void:
	TimeTracker.unpause()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://world.tscn")

func _on_continue_pressed() -> void:
	TimeTracker.unpause()
	self.queue_free()

func shiftHighlight(button) -> void:
	%Highlight.reparent(button.get_parent())
