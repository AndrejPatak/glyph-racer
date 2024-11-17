extends StaticBody2D

@onready var lockAnim = %lock

func _on_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Keys: ", TimeTracker.collectedKeys)
		if TimeTracker.currentTrack in TimeTracker.collectedKeys:
			if lockAnim:
				lockAnim.play("hide")
			%lock.play("hide")
			queue_free()
			
