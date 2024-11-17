extends Node2D

var dialogueFile := preload("res://dialogue.tscn")


@onready var world := get_parent()
@onready var player = world.player

var boost_visible : bool = false

var spike_visible : bool = false

var dialogueEnded : bool = false


func _ready() -> void:
	%border.modulate = Colorizer.get_color("danger")
	%Finish.modulate = Colorizer.get_color("track")

# Called when the node enters the scene tree for the first time.
func displayDialogue() -> void:
	var dialogueNode : Control
	dialogueEnded = false
	dialogueNode = dialogueFile.instantiate()
	dialogueNode.dialogs.clear()
	var dialogs : Array[String] = ["Hey! You're not supposed to be here!", "Don't you know what happens to a ferign porccess?", "If you want to live, you'll have to get out of here.", "I can guide you out...", "You'll have to follow this arrow. Go straight into the exit and you'll move on to the next proccess layer."]
	dialogueNode.set_dialogs(dialogs)
	TimeTracker.ui_layer.add_child(dialogueNode)
	dialogueNode.connect("show_arrow", show_arrow)
	

func show_arrow() -> void:
	player.arrow.start(%Finish)
	dialogueEnded = true

func explain_boosts() -> void:
	
	if boost_visible and dialogueEnded:
		var dialogs : Array[String] = ["Oh look, some boosts!", "Use [RIGHT MOUSE BUTTON] to activate boost.", "They'll help you move faster, but they get removed every time you hop a layer.", "Make sure you use them wisely..."]
		
		var dialogueNode = dialogueFile.instantiate()
		dialogueNode.set_dialogs(dialogs)
		TimeTracker.ui_layer.add_child(dialogueNode)

func explain_spikes() -> void:
	if spike_visible and dialogueEnded:
		
		var dialogs : Array[String] = ["Oh sh*t!", "Those red spikes must've been traps the host system set.", "Try to avoid them. They end your proccess as soon as you touch them."]
		
		var dialogueNode = dialogueFile.instantiate()
		dialogueNode.set_dialogs(dialogs)
		TimeTracker.ui_layer.add_child(dialogueNode)

func _on_boost_trigger_explenation() -> void:
	if !boost_visible:
		boost_visible = true
		explain_boosts()


func _on_spike_screen_entered() -> void:
	if !spike_visible:
		spike_visible = true
		explain_spikes()
