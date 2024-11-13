extends Node2D
@export var spriteName : String

func _ready() -> void:
	modulate = Colorizer.get_color(spriteName)
