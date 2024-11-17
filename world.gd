extends Node2D

@onready var TimerHandler := %UI.get_node("TimerHandler")
var victoryFile = preload("res://victory.tscn")

var deathFile = preload("res://death_screen.tscn")

var started : bool = false
var startCounter : int = 0

var track_node : PackedScene
var trackInstance

@onready var player = %player

var currentLoop : int = -1
var loops_amount : int = 0

@onready var loop_counter := %UI.get_node("loop_counter")

func _ready() -> void:
	%RaceStart.modulate = Colorizer.get_color("player")
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
		"track_5":
			track_node = preload("res://track_5.tscn")
		"track_6":
			track_node = preload("res://track_6.tscn")
			loops_amount = 3
		"track_7":
			track_node = preload("res://track_7.tscn")
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
	_on_start_timer_timeout()
	%player.track = trackInstance
	Settings.set_volume("effects", Settings.effects_volume)
	
	if loops_amount > 0:
		update_loop_counter()
	
func startRace():
	started = true
	TimerHandler.paused = false
	if TimeTracker.currentTrack == "track_1":
		trackInstance.displayDialogue()

func finishRace(_body):
	if TimeTracker.currentTrack not in TimeTracker.loopTracks:
		finsish()
	else:
		if currentLoop < loops_amount:
			currentLoop += 1
			update_loop_counter()
		else:
			finsish()

func finsish() -> void:
	$player.stop_exhaust()
	var victoryScreen = victoryFile.instantiate()
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
				%text.text = "[GO!]"
			_:
				printerr("Erm... what the sigma?")
		startCounter += 1
	else:
		%RaceStart.queue_free()
		startRace()


func _on_player_player_died() -> void:
	$player.stop_exhaust()
	var deathScreen = deathFile.instantiate()
	%ui_layer.add_child(deathScreen)
	TimerHandler.paused = true
	TimeTracker.memorize_track_time(TimeTracker.currentTrack, TimerHandler.time)
	print(TimeTracker.times)

func update_loop_counter() -> void:
	loop_counter.text = str(currentLoop) + "/" + str(loops_amount)
