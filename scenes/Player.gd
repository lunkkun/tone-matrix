extends Node


export(int, 60, 480) var bpm = 240 setget set_bpm

var beat = -1


func _ready():
	$Timer.start()


func set_bpm(value):
	bpm = value
	$Timer.wait_time = 60.0 / bpm
	
	$"/root/SaveFile".save()


func next_beat():
	beat += 1
	beat %= $ToneMatrix.beats
	play()


func play():
	$ToneMatrix.play(beat)


func _on_Timer_timeout():
	next_beat()


func _unhandled_key_input(event):
	if event.is_action_pressed("speed_up") and bpm < 480:
		set_bpm(bpm + 1)
	elif event.is_action_pressed("speed_down") and bpm > 60:
		set_bpm(bpm - 1)
