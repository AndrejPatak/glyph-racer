extends Area2D

@export var strength : float = 50
@export var spriteName : String = "player"

func _ready() -> void:
	modulate = Colorizer.get_color(spriteName)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.launch(strength)
