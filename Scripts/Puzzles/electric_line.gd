@tool
extends Node3D
class_name ElectricLine

@export var is_source: bool
@export var path: ElectricPath
@onready var pathmesh: PathMesh3D = $PathMesh3D

@onready var start_collider: CollisionShape3D = $Conductive/StartCollider
@onready var end_collider: CollisionShape3D = $Conductive/EndCollider

var texture_offset1: Vector3 = Vector3.ZERO
var texture_offset2: Vector3 = Vector3.ZERO

@onready var material_active: Material = load("res://Material/electric_line_active1.tres")
@onready var material_overlay: Material = load("res://Material/electric_line_active_overlay.tres")
@onready var material_disabled: Material = load("res://Material/electric_line_disabled.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	child_entered_tree.connect(on_child_entered)
	load_path()
	$Conductive.is_source = self.is_source

func load_path():
	pathmesh.path_3d = self.path
	on_curve_changed()

func on_child_entered(node: Node):
	if node is ElectricPath:
		path = node
		if !self.path.curve_changed.is_connected(self.on_curve_changed):
			self.path.curve_changed.connect(self.on_curve_changed)
		load_path()

func on_curve_changed():
	var start_point: Vector3 = path.curve.get_point_position(0)
	var end_point: Vector3 = path.curve.get_point_position(path.curve.point_count - 1)

	start_collider.position = start_point
	end_collider.position = end_point

func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		if $Conductive.is_active:
			pathmesh.material_override = material_active
			pathmesh.material_overlay = material_overlay
		else:
			pathmesh.material_overlay = material_disabled
			pathmesh.material_override = material_disabled

		texture_offset1.x += delta * 0.05
		texture_offset2.x -= delta * 0.01


		pathmesh.material_override.set("uv1_offset", texture_offset1)
		pathmesh.material_overlay.set("uv1_offset", texture_offset2)
