extends MeshInstance3D

@onready var selectable_component: Selectable = $Selectable
signal play_btn_pressed
var _default_position: Vector3
var _clicked_position: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectable_component.mesh_instance = self
	selectable_component.select = handle_select

	_default_position = position
	_clicked_position = position - Vector3(0, 0, 0.05)


func handle_select() -> void:
	animate_click()
	play_btn_pressed.emit()

func animate_click():
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", _clicked_position, 0.1)
	tween.tween_property(self, "position", _default_position, 0.1)
