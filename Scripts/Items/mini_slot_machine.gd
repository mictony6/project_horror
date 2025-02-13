extends Node3D
class_name MiniSlotMachine

@onready var label: Label = $SubViewport/Control/Label
@export var panelstyle: StyleBoxFlat


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func use():
	label.text = str(randi_range(0, 100))
	panelstyle.bg_color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))