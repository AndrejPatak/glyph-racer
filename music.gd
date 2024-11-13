extends Node

var songs : Array = []

var songsPath = "./assets/music/background/"
var currentSong : AudioStreamMP3
var songIndex : int = 0

var musicPlaying : bool = false

func _ready() -> void:
	
	getSongs()
	currentSong = load(songsPath + songs.pick_random())
	songIndex = songs.bsearch(currentSong)
	startMusic()
	notifySong("Now playing: " + %audioStream.stream.resource_path.get_file().replace(".mp3", ""))

func nextSong() -> void:
	pauseMusic()
	if songIndex < songs.size() - 1:
		songIndex += 1
	else:
		songIndex = 0
	currentSong = load(songsPath + songs[songIndex])
	startMusic()
	
	notifySong("Now playing next song: " + %audioStream.stream.resource_path.get_file().replace(".mp3", ""))
	
func prevSong() -> void:
	pauseMusic()
	currentSong = load(songsPath + songs[songs.bsearch(currentSong) - 1])
	startMusic()
	notifySong("Now playing previous song: " + %audioStream.stream.resource_path.get_file().replace(".mp3", ""))
	
func playSpecificSong(song : String) -> void:
	pauseMusic()
	currentSong = load(songsPath + songs[songs.bsearch(song)])
	startMusic()
	notifySong("Now playing: " + %audioStream.stream.resource_path.get_file().replace(".mp3", ""))

func pauseMusic() -> void:
	notifySong("Music paused.")
	%audioStream.stop()
	musicPlaying = false
	
func startMusic() -> void:
	%audioStream.set_stream(currentSong)
	%audioStream.play(0.0)
	musicPlaying = true
	
func getSongs() -> void:
	for song in DirAccess.get_files_at("./assets/music/background/"):
		if song.ends_with(".mp3"):
			songs.append(song)
	
func notifySong(message : String) -> void:
	TimeTracker.notify(message)

func setVolume(volume) -> void:
	var db : float = -50 / (volume * 5) + 10
	%audioStream.volume_db = db
	pass
	

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("dbg_next_song"):
		nextSong()
	if Input.is_action_just_pressed("dbg_prev_song"):
		prevSong()
	if Input.is_action_just_pressed("dbg_music_play_pause"):
		if musicPlaying:
			pauseMusic()
		else:
			startMusic()
			notifySong("Now playing: " + %audioStream.stream.resource_path.get_file().replace(".mp3", ""))
