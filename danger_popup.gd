extends Control

var message : String
var action : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%no.grab_focus()
	%message.text = message
	modulate = Colorizer.get_color("danger")

func _on_no_pressed() -> void:
	self.queue_free()
	

func _on_save_exit() -> void:
	match action:
		"exit":
			get_tree().quit()
		_:
			print("Unknown popup action: ", action)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu_back"):
		self.queue_free()

func _on_exit_pressed() -> void:
	get_tree().quit()
