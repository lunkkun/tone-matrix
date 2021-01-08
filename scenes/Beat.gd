extends Node2D


export var enabled = true setget set_enabled


func set_enabled(value):
	enabled = value
	modulate = Color.white if enabled else Color(.5, .5, .5, .5)


func play():
	for tone in get_children():
		tone.play()
