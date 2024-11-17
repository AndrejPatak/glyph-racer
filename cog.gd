extends StaticBody2D

@export var rotationSpeed : float = 1.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Colorizer.get_color("track")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation += rotationSpeed * delta
