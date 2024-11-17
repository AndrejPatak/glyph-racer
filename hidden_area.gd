extends TextureRect



func _on_triggered(body: Node2D) -> void:
	if body.is_in_group("player"):
		%cover_an.play("show")
		%trigger.queue_free()
