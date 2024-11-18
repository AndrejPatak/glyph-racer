extends Node2D
@onready var world : Node2D = get_parent()
@onready var player : CharacterBody2D = get_tree().root.get_node("/root/world/player")
var diff : float
var init_velocity : float = 8.5
var velocity : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	modulate = Colorizer.get_color("danger")
	diff = abs(player.global_position.x - self.global_position.x)
	for trigger : Area2D in get_tree().get_nodes_in_group("trigger"):
		#print("TRIGGER: ", trigger)
		var indx := get_tree().get_nodes_in_group("trigger").bsearch(trigger)
		#print("INDX: ", indx)
		trigger.connect("trigger", trigger_attack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if player.world.started:
		velocity = move_toward(velocity, init_velocity, 200 * delta)
		global_position.x = move_toward(global_position.x, 1000000, 100 * delta * velocity)


func trigger_attack(what : String) -> void:
	#print(what)
	match what:
		"bite":
			%animate.stop()
			%animate.play("bite")
			#print("bite")
		"laser":
			%anim.active = true
			var tween := get_tree().create_tween()
			var target_position := global_position.y + randi_range(-300, 300)
			var original_position = global_position.y
			tween.tween_property(self, "global_position", Vector2(global_position.x, target_position), .5)
			#print("laser")
			return_y(original_position)
			pass
		"speed_up":
			var timer := get_tree().create_timer(.5)
			init_velocity = 9
			timer.connect("timeout", slow)
		_:
			printerr("Unhandled anti_virus trigger.")

func slow() -> void:
	init_velocity = 8.5

func return_y(to : float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "global_position", Vector2(global_position.x, to), .5)


func _on_beam_danger_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()


func _on_bottom_danger_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "laser_shooting":
			%anim.active = false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	init_velocity = 85


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	init_velocity = 8.5
