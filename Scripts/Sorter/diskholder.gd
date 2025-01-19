extends Node3D

var closed: bool = false

@onready var disk_mesh: MeshInstance3D = $DiskholderMesh
@onready var selectable_component: Selectable = $DiskholderMesh/Selectable

var disk_item: Item = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectable_component.mesh_instance = disk_mesh
	selectable_component.select = handle_select

func handle_select() -> void:
	# dont allow selecting if the diskholder is closed or is empty
	if !has_disk() or closed:
		return

	selectable_component.switch_interaction_label()

# when its opened, the diskholder can be selected
func _on_open_close_opened() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(disk_mesh, "position", Vector3(0, 0, 0), 0.5)
	closed = false
	selectable_component.can_be_selected = true

# when its closed, the diskholder cannot be selected
func _on_open_close_closed() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(disk_mesh, "position", Vector3(0, 0, -0.7), 0.5)
	closed = true
	selectable_component.can_be_selected = false

func has_disk() -> bool:
	return disk_item != null
