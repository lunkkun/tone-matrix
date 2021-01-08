tool
extends Area2D


const MODULATE_PLAYING = Color.white
const MODULATE_NOT_PLAYING = Color.gray

export(Color) var color = Color.white
export(AudioStream) var sample
export var enabled = false setget set_enabled


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sample.stream = sample
	$Sprite.modulate = color


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		set_enabled(not enabled)


func set_enabled(value):
	enabled = value
	modulate = Color.white if enabled else Color(.5, .5, .5)
	
	$"/root/SaveFile".save()


func play():
	var flash_color = MODULATE_NOT_PLAYING
	if enabled:
		$Sample.play()
		flash_color = MODULATE_PLAYING
	
	$Tween.interpolate_property($Sprite, "modulate", flash_color, color, 0.4)
	$Tween.start()
