extends Node3D
class_name Door
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var selectable_component: Selectable = $Plane/Plane_002/Selectable

var _opened = false

func _ready() -> void:
	selectable_component.select = handle_interaction
	if !_opened:
		close_door()

func handle_interaction():
	if !_opened:
		open_door()
	else:
		close_door()
	selectable_component.switch_interaction_label()


func open_door():
	animation_player.play("Open")
	_opened = true

func close_door():
	animation_player.play("Close")
	_opened = false
