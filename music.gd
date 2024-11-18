extends Node

var songs : Array = []

var songsPath = "./assets/music/background/"
var currentSong : AudioStreamMP3
var songIndex : int = 0

var musicPlaying : bool = false

var controlable : bool = true

func _ready() -> void:
	getSongs()
	currentSong = load(songsPath + songs.pick_random())
	songIndex = songs.bsearch(currentSong)
	startMusic()
	notifySong("Now playing: " + get_song_filename())

func nextSong() -> void:
	pauseMusic()
	if songIndex < songs.size() - 1:
		songIndex += 1
	else:
		songIndex = 0
	currentSong = load(songsPath + songs[songIndex])
	startMusic()
	
	notifySong("Now playing next song: " + get_song_filename())
	
func prevSong() -> void:
	pauseMusic()
	if songIndex > 0:
		songIndex -= 1
	else:
		songIndex = songs.size() - 1
	currentSong = load(songsPath + songs[songIndex])
	startMusic()
	
	notifySong("Now playing next song: " + get_song_filename())
	
func playSpecificSong(song : String) -> void:
	pauseMusic()
	currentSong = load(songsPath + songs[songs.bsearch(song)])
	startMusic()
	notifySong("Now playing: " + get_song_filename())

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


func get_song_filename() -> String:
	return %audioStream.stream.resource_path.get_file().replace(".mp3", "")
