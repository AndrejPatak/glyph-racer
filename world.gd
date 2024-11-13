extends Node2D

@onready var TimerHandler := %UI.get_node("TimerHandler")
var victoryFile = preload("res://victory.tscn")


func _ready() -> void:
	var ui := %ui_layer
	TimeTracker.load_ui_layer(ui)
	var track_node : PackedScene
	match TimeTracker.currentTrack:
		"track_1":
			track_node = preload("res://tutorialTrack.tscn")
		"track_2":
			track_node = preload("res://track_2.tscn")
		"track_3":
			track_node = preload("res://track_3.tscn")
		"track_4":
			track_node = preload("res://track_4.tscn")
		_:
			track_node = preload("res://tutorialTrack.tscn")
			TimeTracker.notify("WARNING: " + TimeTracker.currentTrack + " not found!!")
	var trackInstance = track_node.instantiate()
	
	add_child(trackInstance)
	if(trackInstance.get_node("Finish")):
		trackInstance.get_node("Finish").connect("body_entered", finishRace)
	else:
		print("Nodes in trackInstance: ", trackInstance.get_children(), "\ntrackInstance.get_node('Finish'): ", trackInstance.get_node("Finsih"))
		pass
	startRace()

func startRace():
	TimerHandler.paused = false

func finishRace(_body):
	var victoryScreen = victoryFile.instantiate()
	$player.stop_exhaust()
	%ui_layer.add_child(victoryScreen)
	TimerHandler.paused = true
	TimeTracker.memorize_track_time(TimeTracker.currentTrack, TimerHandler.time)
	print(TimeTracker.times)
	
	TimeTracker.finish()
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		TimeTracker.pause()
