extends Control

var currentText : int = 0
var talking : String
var speaker : String = "[UNKNOWN]"
var dialogs : Array[String]

var finished : bool = false

signal dialogue_ended

var tween : Tween
var duration : float = 1.5

func _ready() -> void:
	%next.grab_focus()
	if dialogs.size() == 0:
		dialogs = ["You didnt tell me what to say.", "Now im gonna say gibbirish.", "How dare you...", "adasdasfhgasdhfgdshfksjbvcskdbvdjsvcasjcah"]
	displayNext()
	modulate = Colorizer.get_color("danger")

func set_dialogs(toWhat : Array[String]) -> void:
	dialogs = toWhat

func animate_text() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(%label, "visible_ratio", 1, duration)
	
func skip_tween() -> void:
	tween.custom_step(duration)

func displayNext() -> void:
	%label.text = ""
	%speaker.text = speaker
	%label.visible_ratio = 0
	
	%label.text = dialogs[currentText]
	animate_text()
	
	if currentText < dialogs.size() - 1:
		currentText += 1
	else:
		dialogue_ended.emit()

func _on_next_pressed() -> void:
	
	if tween.is_running():
		skip_tween()
	else:
		if !finished:
			displayNext()
		else:
			modulate = Color.TRANSPARENT
			pass

func _on_dialogue_ended() -> void:
	%next.text = "X"
	finished = true
