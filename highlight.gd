extends Label

func _ready() -> void:
	
	for button in get_tree().get_nodes_in_group("button"):
			#print(button)
			button.connect("focus_entered", highlightButton.bind(button))
			#print(button, " Disabled: ", button.disabled)
			
				
			
func setup(button) -> void:
	reparent(button.get_parent(	))
func highlightButton(button : Button) -> void:
	#print("Focus change detected to button: ", button)
	self.reparent(button.get_parent_control())
	#print("focused to: ",button)
