extends AnimationPlayer




func _on_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		play("reveal")
		%trigger.queue_free()
