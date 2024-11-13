extends Node2D

@export var next_smasher : Node2D = null

func _ready() -> void:
	%ColorRect.color = Colorizer.get_color("track")

func startOscilate(offset : float) -> void:
	%warning.play("warning")
	await get_tree().create_timer(offset).timeout
	%anim.play("oscilate")
	$warning2.queue_free()
	%warning.queue_free()
	if next_smasher:
		next_smasher.startOscilate(offset)
	



func _on_smasher_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and self == get_tree().get_nodes_in_group("Smasher")[0]:
		startOscilate(0.5)
