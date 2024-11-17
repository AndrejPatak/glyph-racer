extends Node2D
@export var spriteName : String


func _ready() -> void:
	modulate = Colorizer.get_color(spriteName)
	for decor in get_tree().get_nodes_in_group("decor"):
		decor.modulate = Colorizer.get_color("track")
