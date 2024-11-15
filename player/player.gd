extends CharacterBody2D
@export var nitrusStrength : float = 1.5 
@export var accel : float = 450.0
@export var maxSpeed : float = 900.0
@export var friction : float = 0.5

@onready var world : Node2D = get_parent()
@onready var arrow := %Pointer

var isMoving : bool = false # used to check for mouse input.
var boost : float # used to track if nitrus boost should be applied

var boostAmount : float = 0

var track : Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%exhaust.modulate = Colorizer.get_color("player")
	%Pointer.modulate = Colorizer.get_color("track")

func get_angle_to_mouse() -> float:
	var x := get_global_mouse_position().x - self.global_position.x
	var y := get_global_mouse_position().y - self.global_position.y
	
	return atan(y/x)

func get_relative_mouse_position() -> Vector2:
	var x := get_global_mouse_position().x - self.global_position.x
	var y := get_global_mouse_position().y - self.global_position.y
	return Vector2(x, y)

func distance_amplifier() -> float:
	return sqrt(pow(get_relative_mouse_position().normalized().x, 2) + pow(get_relative_mouse_position().normalized().y, 2)) * 2
func loop_engine_sound(anim):
	if Input.is_action_pressed("forward"):
		%engineSound.seek(3.5)
		%engineSound.play(anim)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	
	%UI.get_node("boostMeter").value = boostAmount
	
	if Input.is_action_pressed("boost") and boostAmount > 0:
		boost = nitrusStrength * int(Input.is_action_pressed("boost"))
		%Camera2D.zoom.x = move_toward(%Camera2D.zoom.x, 0.6, 0.1 * delta)
		%Camera2D.zoom.y = move_toward(%Camera2D.zoom.y, 0.6, 0.1 * delta)
		boostAmount = move_toward(boostAmount, 0, .5	)
	else:
		boost = move_toward(boost, 1, delta * (accel / maxSpeed))
		%Camera2D.zoom.x = move_toward(%Camera2D.zoom.x, 0.8, 0.2 * delta)
		%Camera2D.zoom.y = move_toward(%Camera2D.zoom.y, 0.8, 0.2 * delta)
	if Input.is_action_just_pressed("forward"):
		%engineSound.play("engine")
	if Input.is_action_just_released("forward"):
		%engineSound.stop()
	if Input.is_action_pressed("forward"):
		isMoving = true
		if world.started:
			velocity.x = move_toward(velocity.x, get_relative_mouse_position().normalized().x * (maxSpeed * distance_amplifier() / 2) * boost, boost * accel * distance_amplifier() * delta)
			velocity.y = move_toward(velocity.y, get_relative_mouse_position().normalized().y * (maxSpeed * distance_amplifier() / 2)  * boost, boost * accel * distance_amplifier() * delta)
	else:
		isMoving = false
		if world.started:
			velocity.x = move_toward(velocity.x, 0, friction * maxSpeed * delta)
			velocity.y = move_toward(velocity.y, 0, friction * maxSpeed * delta)
	
	if isMoving:
		%exhaust.emitting = true
	else:
		%exhaust.emitting = false

	#print("Mouse position: ", get_global_mouse_position())
	#print("Mouse position normalized: ", get_global_mouse_position().normalized())
	#print("Mouse position angle: ", get_angle_to(get_global_mouse_position()))
	
	look_at(get_global_mouse_position())
	
	
	if world.started:
		move_and_slide()

func stop_exhaust() -> void:
	%exhaust.emitting = false

func add_boost(amount : float) -> void:
	if boostAmount != 100:
		boostAmount += amount
