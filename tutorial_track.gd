extends Node2D

var dialogueFile := preload("res://dialogue.tscn")


@onready var world := get_parent()
@onready var player = world.player

var boost_visible : bool = false

var dialogueEnded : bool = false
func _ready() -> void:
	modulate = Colorizer.get_color("track")

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
	dialogueNode.connect("dialogue_ended", explain_boosts)

func show_arrow() -> void:
	player.arrow.start(%Finish)
	dialogueEnded = true

func explain_boosts() -> void:
	
	if boost_visible and dialogueEnded:
		var dialogs : Array[String] = ["Oh look, some boosts!", "They'll help you move faster, but they get removed every time you hop a layer.", "Make sure you use them wisely..."]
		
		var dialogueNode = dialogueFile.instantiate()
		dialogueNode.set_dialogs(dialogs)
		TimeTracker.ui_layer.add_child(dialogueNode)

func _on_boost_trigger_explenation() -> void:
	if !boost_visible:
		boost_visible = true
		explain_boosts()
