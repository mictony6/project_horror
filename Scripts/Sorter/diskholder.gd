extends MeshInstance3D
var closed: bool = false

@onready var selectable_component: Selectable = $Selectable
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectable_component.mesh_instance = self
	selectable_component.select = handle_select

func handle_select() -> void:
	if closed:
		open()
	else:
		close()

func open() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector3(position.x, position.y, 1.0), 0.5)
	closed = !closed

func close() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector3(position.x, position.y, 0.3), 0.5)
	closed = !closed
