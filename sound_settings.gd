extends Node2D

@export_range(0.0, 1.0, .1) var music_volume : float
@export_range(0.0, 1.0, .1) var effects_volume : float

func set_volume(forWhat : String, toWhat : float = 0.7) -> void:
	match forWhat:
		"music":
			music_volume = toWhat
			Music.setVolume(music_volume)
		"effects":
			effects_volume = toWhat
		_:
			printerr("Unknown sound type: ", forWhat, "; Recieved value: ", toWhat)

func get_volume(forWhat : String) -> void:
	match forWhat:
		"music":
			pass
		"effect":
			pass
		_:
			printerr("Unknown sound type: ", forWhat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
