extends ColorRect



func _on_triggered(body: Node2D) -> void:
	if body.is_in_group("player"):
		%anim.play("reveal")
		get_child(0).queue_free()
