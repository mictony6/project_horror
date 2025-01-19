extends MeshInstance3D

@onready var selectable_component: Selectable = $Selectable
var is_closed: bool = false
signal opened
signal closed

var _default_position: Vector3
var _clicked_position: Vector3

func _ready() -> void:
	_default_position = position
	_clicked_position = position - Vector3(0, 0, 0.05)
	selectable_component.mesh_instance = self
	selectable_component.select = toggle

func toggle() -> void:
	animate_click()
	is_closed = !is_closed
	selectable_component.switch_interaction_label()
	if !is_closed:
		opened.emit()
	else:
		closed.emit()

func animate_click():
	var tween: Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", _clicked_position, 0.1)
	tween.tween_property(self, "position", _default_position, 0.1)
