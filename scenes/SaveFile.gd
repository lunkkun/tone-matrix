extends Node


signal requested_save

var path = "user://savedata.save"
var exists = null setget ,get_exists

var bpm: int
var beats: int
var matrix: Array


func get_exists():
	if exists == null:
		var file = File.new()
		exists = file.file_exists(path)
	
	return exists


func read():
	var file = File.new()
	file.open(path, File.READ)
	
	var meta = parse_json(file.get_line())
	bpm = meta[0]
	beats = meta[1]
	
	matrix = []
	for i in range(16):
		var beat = parse_json(file.get_line())
		matrix.append(beat)
	
	file.close()


func write():
	var file = File.new()
	file.open(path, File.WRITE)
	
	file.store_line(to_json([bpm, beats]))
	
	for beat in matrix:
		file.store_line(to_json(beat))
	
	file.close()
	
	exists = true
	
	print("save file written")


func save():
	emit_signal("requested_save")
