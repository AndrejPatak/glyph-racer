extends Control


func _ready() -> void:
	update()

func _on_previous_pressed() -> void:
	Music.prevSong()
	update()
	


func _on_pause_play_pressed() -> void:
	if Music.musicPlaying:
		Music.pauseMusic()
		%pause_play.text = ">"
	else:
		Music.startMusic()
		%pause_play.text = "| |"


func _on_next_pressed() -> void:
	Music.nextSong()
	update()
	

func update() -> void:
	%title.text = "[" + Music.get_song_filename() + "]"
