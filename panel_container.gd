extends PanelContainer

@export var messges : Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%message.text = messges.pick_random()
	pass
