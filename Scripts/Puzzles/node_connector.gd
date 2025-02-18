class_name ElecNodeConnector extends Node3D

var is_on: bool = true
@onready var start_node: Node3D
@onready var end_node: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_child_count() > 0:
		end_node = get_child(0)
		start_node = get_child(get_child_count() - 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
