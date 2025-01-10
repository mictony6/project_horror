extends Node3D
class_name Door
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _opened = false

func _ready() -> void:
	if !_opened:
		close_door()

func handle_interaction(item: Item):
	if !_opened:
		open_door()
	else:
		close_door()


func open_door():
	animation_player.play("open")
	_opened = true

func close_door():
	animation_player.play("close")
	_opened = false
