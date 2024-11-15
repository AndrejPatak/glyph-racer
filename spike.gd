extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Colorizer.get_color("danger")


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
	else:
		print("Body: ", body.name, " collided with spikes.")
