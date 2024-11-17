extends Node2D

@export var next_smasher : Node2D = null
@export var distance : float = 200
@export var offset : float = 1
@export var first : bool = false

@export var smashIndex : int = 0

var warn : bool = false



signal forward
signal backward

func _ready() -> void:
	%ColorRect.color = Colorizer.get_color("danger")
	$warning2/Sprite2D.modulate = Colorizer.get_color("danger")
	startOscilate(.1)

func startOscilate(offset : float) -> void:
	if not warn:
		%warning.play("warning")
		warn = true
	await get_tree().create_timer(offset).timeout

	if not warn:
		$warning2.queue_free()
		%warning.queue_free()
	if next_smasher:
		next_smasher.startOscilate(offset)
	if not first:
		await get_tree().create_timer(offset + float(smashIndex) / 5).timeout
	go()

#func oscilate() -> void:
	#await go()
	#await back()
	#pass

func go():
	
	var target : Vector2 = position + Vector2(distance, 0)
	await get_tree().create_timer(offset).timeout
	var tween := get_tree().create_tween()
	tween.connect("finished", back, CONNECT_ONE_SHOT)
	await tween.tween_property(self, "position", target, .5).finished
	
	

func back():
	
	var target : Vector2 = position - Vector2(distance, 0)
	await get_tree().create_timer(offset).timeout
	var tween := get_tree().create_tween()
	tween.connect("finished", go, CONNECT_ONE_SHOT)
	await tween.tween_property(self, "position", target, .5).finished
	

func _on_smasher_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and self == get_tree().get_nodes_in_group("Smasher")[0] and warn:
		startOscilate(0.5)


func _on_danger_collider_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
		

func enable_death(body : Node2D) -> void:
	if body.is_in_group("player"):
		%danger_collider.set_deferred("monitoring", true)
		%smasher_collider.disabled = false


func disable_death(body : Node2D) -> void:
	if body.is_in_group("player"):
		%danger_collider.set_deferred("monitoring", false)
		%smasher_collider.disabled = true
