extends Node


onready var save_file = get_node("/root/SaveFile")

# Called when the node enters the scene tree for the first time.
func _ready():
	if save_file.exists:
		load_save_file()
	else:
		write_save_file()
	
	call_deferred("connect_save_file") # to avoid triggering on initialization


func connect_save_file():
	save_file.connect("requested_save", self, "write_save_file")


func load_save_file():
	save_file.read()
	
	$Player.bpm = save_file.bpm
	$Player/ToneMatrix.beats = save_file.beats
	
	for i in range(16):
		var beat = $Player/ToneMatrix.get_child(i)
		var data = save_file.matrix[i]
		for j in range(16):
			var tone = beat.get_child(j)
			tone.enabled = data[j]


func write_save_file():
	save_file.bpm = $Player.bpm
	save_file.beats = $Player/ToneMatrix.beats
	save_file.matrix = []
	
	for i in range(16):
		var beat = $Player/ToneMatrix.get_child(i)
		var data = []
		for j in range(16):
			var tone = beat.get_child(j)
			data.append(tone.enabled)
		save_file.matrix.append(data)
	
	save_file.write()
