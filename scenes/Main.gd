extends Node


export(int, 60, 480) var bpm = 240 setget set_bpm

var beat = 0


func _ready():
	$Timer.start()
	play()


func set_bpm(value):
	bpm = value
	$Timer.wait_time = 60.0 / bpm


func next_beat():
	beat += 1
	beat %= $ToneMatrix.beats
	play()


func play():
	$ToneMatrix.play(beat)


func _on_Timer_timeout():
	next_beat()
