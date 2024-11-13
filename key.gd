extends Area2D

@export var keyID : String = "track_1"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Colorizer.get_color("player")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$sound.play(0.0)
		TimeTracker.collectedKeys.append(keyID)
		$GPUParticles2D.emitting = true
		$Sprite2D.modulate = Color.TRANSPARENT
		pass


func _on_gpu_particles_2d_finished() -> void:
	self.queue_free()
