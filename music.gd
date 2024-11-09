extends Node

var songs = [""]

func _ready() -> void:
	getSongs()

func nextSong() -> void:
	pass
	
func prevSong() -> void:
	pass
	
func playSpecificSong(song : String) -> void:
	pass

func pauseMusic() -> void:
	pass
func startMusic() -> void:
	pass
	
func getSongs() -> void:
	print(DirAccess.get_files_at("./assets/music/"))
