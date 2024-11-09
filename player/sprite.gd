extends Node2D
@export var spriteName : String

func _ready() -> void:
	get_child(0).modulate = Colorizer.get_color(spriteName)
