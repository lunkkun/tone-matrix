extends Node2D


export(int, 1, 16) var beats = 16 setget set_beats


func set_beats(value):
	beats = value
	
	print("set beats to " + str(beats))
	
	var count = 0
	for beat in get_children():
		beat.enabled = count < beats
		count += 1
	
	$"/root/SaveFile".save()


func play(beat):
	get_child(beat).play()


func reset():
	for beat in get_children():
		beat.reset()
	
	$"/root/SaveFile".save()


func _unhandled_key_input(event):
	if event.is_action_pressed("add_beat") and beats < 16:
		set_beats(beats + 1)
	elif event.is_action_pressed("remove_beat") and beats > 1:
		set_beats(beats - 1)
	elif event.is_action_pressed("clear_pattern"):
		reset()
