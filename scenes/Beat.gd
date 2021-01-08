extends Node2D


const DISABLED_MODULATE = Color(.5, .5, .5, .5)

export var enabled = true setget set_enabled


func set_enabled(value):
	enabled = value
	modulate = Color.white if enabled else DISABLED_MODULATE


func play():
	for tone in get_children():
		tone.play()


func reset():
	for tone in get_children():
		tone.set_enabled(false, false)
