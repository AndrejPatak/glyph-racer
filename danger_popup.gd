extends Control

var message : String
var action : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%no.grab_focus()
	%message.text = message

func _on_no_pressed() -> void:
	self.queue_free()
	

func _on_save_exit() -> void:
	match action:
		"exit":
			get_tree().quit()
		_:
			print("Unknown popup action: ", action)
