extends VBoxContainer
class_name CDDisplay

func _ready() -> void:
	add_to_group("draggable")

func _get_drag_data(at_position: Vector2) -> Variant:
	var cpb = self.duplicate()
	set_drag_preview(cpb)
	return get_parent()