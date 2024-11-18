extends ColorRect

@export var distance : float = 500



#func fire() -> void:
	#%beam_animate.play("show_beam")
#
#
#
#func _on_anim_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "laser_prep":
		#fire()
