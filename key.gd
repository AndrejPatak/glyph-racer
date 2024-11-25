extends Area2D

var keyID : String = TimeTracker.currentTrack
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Colorizer.get_color("player")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$sound.play(0.0)
		TimeTracker.collectedKeys.append("track_" + str(TimeTracker.curTrackID + 1))
		$GPUParticles2D.emitting = true
		$Sprite2D.modulate = Color.TRANSPARENT
		pass


func _on_gpu_particles_2d_finished() -> void:
	self.queue_free()
