extends Node

var time : float = 0.00
var timeString : String = ""

var paused : bool = true

func timeStep() -> void:
	time += 0.01
	time = snapped(time, 0.01)

func resetTime() -> void:
	time = 0.00

func _process(_delta) -> void:
	if not paused:
		get_tree().create_timer(.01).connect("timeout", timeStep)
		var minutes : int = 0
		if time >= 60:
			minutes = int(time) / 60
			#print("test: ", time - minutes * 60)
			
			if minutes > 10:
				if time - minutes * 60 < 10:
					timeString = str(minutes) + ":0" + str("%.2f" % [time - minutes * 60])
				else:
					timeString = str(minutes) + ":" + str("%.2f" % [time - minutes * 60])
					
			else:
				if time - minutes * 60 < 10:
					timeString = "0" + str(minutes) + ":0" + str("%.2f" % [time - minutes * 60])
				else:
					timeString = "0" + str(minutes) + ":" + str("%.2f" % [time - minutes * 60])
				
		else:
			if time - minutes * 60 < 10:
				timeString = "00" + ":0" + str("%.2f" % [time - minutes * 60])
			else:
				timeString = "00" + ":" + str("%.2f" % [time - minutes * 60])
				
		
		%Timer.text = timeString
		TimeTracker.currentTime = time
