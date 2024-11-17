extends Area2D

@export_range(0, 100) var boost_amount : float

func _ready() -> void:
	modulate = Colorizer.get_color("track")

func delete() -> void:
	set_deferred("monitoring", false)
	$Sprite2D.hide()
	$explode.emitting = true
	%sound.play()
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_boost"):
		body.add_boost(boost_amount)
		delete()


func _on_sound() -> void:
	queue_free()
