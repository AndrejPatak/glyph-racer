extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for dec : AnimationPlayer in get_tree().get_nodes_in_group("anims"):
		dec.play("slide")
