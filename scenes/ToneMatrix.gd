extends Node2D


export(int, 1, 16) var beats = 16 setget set_beats


func set_beats(value):
	beats = value
	
	var count = 0
	for beat in get_children():
		beat.enabled = count < beats
		count += 1


func play(beat):
	get_child(beat).play()
