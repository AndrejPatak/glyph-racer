extends Area2D

@export var what : String = "bite"
signal trigger



func _on_body_entered(body: Node2D) -> void:
	#print("Bod: ", body.name)
	if body.is_in_group("player"):
		#print("sending trigger")
		trigger.emit(what)
