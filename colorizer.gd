extends Node

@export var playerColor : Color
@export var wallsColor : Color
@export var dangerColor : Color
@export var backgroundColor : Color

func get_color(spriteName) -> Color:
	match spriteName:
		"player":
			return playerColor
		"track":
			return wallsColor
		"danger":
			return dangerColor
		"background":
			return backgroundColor
		_:
			print("Unknown sprite: ", spriteName)
			return Color.MAGENTA
