extends Node2D

@onready var TimerHandler := %UI.get_node("TimerHandler")
var victoryFile = preload("res://victory.tscn")

var started : bool = false
var startCounter : int = 0

var track_node : PackedScene
var trackInstance

@onready var player = %player

func _ready() -> void:
	%RaceStart.modulate = Colorizer.get_color("player")
	match Settings.graphics_quality:
		"mid":
			%WorldEnvironment.environment.glow_enabled = false
		"good":
			%WorldEnvironment.environment.glow_enabled = true
	var ui := %ui_layer
	TimeTracker.load_ui_layer(ui)
	
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
	trackInstance = track_node.instantiate()
	
	add_child(trackInstance)
	if(trackInstance.get_node("Finish")):
		trackInstance.get_node("Finish").connect("body_entered", finishRace)
	else:
		print("Nodes in trackInstance: ", trackInstance.get_children(), "\ntrackInstance.get_node('Finish'): ", trackInstance.get_node("Finsih"))
		pass
	%startTimer.start()
	%player.track = trackInstance
	Settings.set_volume("effects", Settings.effects_volume)

func startRace():
	started = true
	TimerHandler.paused = false
	if TimeTracker.currentTrack == "track_1":
		trackInstance.displayDialogue()

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


func _on_start_timer_timeout() -> void:
	if startCounter < 3:
		%startTimer.start()
		%time.text = str(3 - startCounter)
		
		match startCounter:
			0:
				%text.text = "[READY?]"
			1:
				%text.text = "[SET!]"
			2:
				%text.text = "[GO!!]"
			_:
				printerr("Erm... what the sigma?")
		startCounter += 1
	else:
		%RaceStart.queue_free()
		startRace()
