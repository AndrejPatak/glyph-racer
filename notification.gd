extends Control

var message : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%messege.text = message

func showSelf() -> void:
	%animation.play("show_notification")

func hideSelf() -> void:
	%animation.play("hide_notification")
	


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hide_notification":	
		queue_free()
	else:
		hideSelf()
