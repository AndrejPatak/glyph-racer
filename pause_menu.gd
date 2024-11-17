extends Control

var canHide : bool = false

func _ready() -> void:
	%Continue.grab_focus()
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("focus_entered", shiftHighlight.bind(button))
	modulate = Colorizer.get_color("player")

func _process(_delta) -> void:
	if !Input.is_action_pressed("pause") and not canHide:
		canHide = true
	if Input.is_action_just_pressed("pause") and canHide:
		TimeTracker.unpause()
		self.queue_free()
	
	

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
