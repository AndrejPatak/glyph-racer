extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Colorizer.get_color("player")
	%Timer.modulate = Colorizer.get_color("player")
