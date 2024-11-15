extends Node2D

var dialogueFile := preload("res://dialogue.tscn")
var dialogueNode : Control

@onready var world := get_parent()
@onready var player = world.player

func _ready() -> void:
	modulate = Colorizer.get_color("track")

# Called when the node enters the scene tree for the first time.
func displayDialogue() -> void:
	dialogueNode = dialogueFile.instantiate()
	dialogueNode.dialogs.clear()
	var dialogs : Array[String] = ["Hey! You're not supposed to be here!", "Don't you know what happens to a ferign porccess?", "If you want to live, you'll have to get out of here.", "I can guide you out...", "You'll have to follow this arrow. Go straight into the exit and you'll move on to the next proccess layer."]
	dialogueNode.set_dialogs(dialogs)
	TimeTracker.ui_layer.add_child(dialogueNode)
	dialogueNode.connect("dialogue_ended", func(): player.arrow.start(%Finish))
