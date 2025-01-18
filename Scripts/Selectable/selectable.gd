extends Area3D
class_name Selectable

var mesh_instance: MeshInstance3D
var material_overlay: Material
var select: Callable = (func(): pass )
func _ready() -> void:
	material_overlay = load("res://Material/ObjectHighlightOverlay.tres")


func highlight() -> void:
	mesh_instance.material_overlay = material_overlay

func unhighlight() -> void:
	mesh_instance.material_overlay = null
