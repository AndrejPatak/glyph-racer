extends Node

var times : Dictionary
var tracks_file : FileAccess
var numberOfTracks := 7

var collectedKeys : Array = []

var canContinue : bool = false

var currentTrack : String = "track_1"
var curTrackID : int = 1
var currentTime : float = 0
var savedTime : int = 0

var saveExists : bool

var ui_layer : CanvasLayer

var dangerFile := preload("res://danger_popup.tscn")
var notifFile := preload("res://notification.tscn")

var prevMenu : String = "main"

func save_times() -> void:
	print("Times.size()", times.size())
	print("numberOfTracks", numberOfTracks)
	
	tracks_file = FileAccess.open("./saves/tracks.save", FileAccess.WRITE)
	#print("times:")
	#print(times)
	for track in times:
		#print(times[track])
		var trackLineString : String = track + ":" + str(times[track])
		#print(trackLineString)
		tracks_file.store_line(trackLineString)
	tracks_file.flush()
	tracks_file.close()
	
	
func checkContiue() -> bool:
	tracks_file = FileAccess.open("./saves/tracks.save", FileAccess.READ)
	while(not tracks_file.eof_reached()):
		var track : String = tracks_file.get_line()
		if track != "":
			var track_info := track.split(":")
			#print("Time is: ", track_info[1])
			if(track_info[1] != "??.??"):
				return true
		else:
			print("Reached empty line")
	tracks_file.close()
	return false

func resetTimes() -> void:
	var default_file := FileAccess.open("./saves/default.save", FileAccess.READ)
	var file_string : String = default_file.get_as_text()
	
	tracks_file = FileAccess.open("./saves/tracks.save", FileAccess.WRITE)
	tracks_file.store_string(file_string)
	
	times.clear()
	
	tracks_file.flush()
	
	tracks_file.close()
	
	default_file.close()
	memorize_times()

func load_times() -> void:
	tracks_file = FileAccess.open("./saves/tracks.save", FileAccess.READ)
	
	var labels : Array = get_tree().get_nodes_in_group("track_label")
	var index = 0
	tracks_file.seek(0)
	while(not tracks_file.eof_reached()):
		var track : String = tracks_file.get_line()
		if track != "":
			var track_info := track.split(":")
			times.get_or_add(track_info[0], track_info[1])
			times[track_info[0]] = track_info[1]
			var time = float(track_info[1])
			var minutes : int = 0
			var timeString
			
			
			if time >= 60:
				minutes = int(time) / 60
				if minutes > 10:
					if time - minutes * 60 < 10:
						timeString = str(minutes) + ":0" + str("%.2f" % [time - minutes * 60])
					else:
						timeString = str(minutes) + ":" + str("%.2f" % [time - minutes * 60])
						
				else:
					if time - minutes * 60 < 10:
						timeString = "0" + str(minutes) + ":0" + str("%.2f" % [time - minutes * 60])
					else:
						timeString = "0" + str(minutes) + ":" + str("%.2f" % [time - minutes * 60])
					
			else:
				if time - minutes * 60 < 10:
					timeString = "00" + ":0" + str("%.2f" % [time - minutes * 60])
				else:
					timeString = "00" + ":" + str("%.2f" % [time - minutes * 60])
				
				
			
			print("Label: ", labels[index], " -> ", index)
			print("Time: ", timeString, " -> ", index)
			labels[index].text = timeString
		index += 1
	tracks_file.close()

func memorize_times() -> void:
	tracks_file = FileAccess.open("./saves/tracks.save", FileAccess.READ)
	while(not tracks_file.eof_reached()):
		var track : String = tracks_file.get_line()
		if track != "":
			var track_info := track.split(":")
			times.get_or_add(track_info[0], track_info[1])
		else:
			print("Reached empty line")
	tracks_file.close()

func memorize_track_time(track : String, time : float) -> void:
	times[track] = time

func finish() -> void:
	get_tree().paused = true

func pause() -> void:
	if ui_layer:
		get_tree().paused = true
		var pause_scene := preload("res://pause_menu.tscn")
		var pause_instance := pause_scene.instantiate()
		ui_layer.add_child(pause_instance)
	
func load_ui_layer(node : CanvasLayer) -> void:
	ui_layer = node

func reset_ui_layer() -> void:
	ui_layer = null

func unpause() -> void:
	get_tree().paused = false

func _ready() -> void:
	memorize_times()

func get_track_time() -> float:
	#print(times[currentTrack])
	return float(times[currentTrack])

func quit_game() -> void:
	var dangerPopup = dangerFile.instantiate()
	dangerPopup.action = "exit"
	dangerPopup.message = "You're about to exit the game. \nAny unsaved track times will be erased."
	ui_layer.add_child(dangerPopup)

func notify(text):
	
	var notif := notifFile.instantiate()
	notif.message = text
	if ui_layer:
		print("true: ", ui_layer)
		ui_layer.add_child(notif)
		notif.showSelf()
	else:
		print("false: ", ui_layer)
		self.add_child(notif)
		notif.showSelf()
	
	
