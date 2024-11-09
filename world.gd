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
		_:
			print("PANIKK!!!1!1")
	var trackInstance = track_node.instantiate()
	
	add_child(trackInstance)
	if(trackInstance.get_node("Finsih")):
		trackInstance.get_node("Finsih").connect("body_entered", finishRace)
	else:
		print("Nodes in trackInstance", trackInstance.get_children(), "\ntrackInstance.get_node('Finish'): ", trackInstance.get_node("Finsih"))
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
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		TimeTracker.pause()
