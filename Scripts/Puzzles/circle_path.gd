@tool
extends Path3D
@onready var path_follow: PathFollow3D = $PathFollow3D

@onready var left_select: Selectable = $PathFollow3D/LogicColumn/LeftSelectable
@onready var right_select: Selectable = $PathFollow3D/LogicColumn/RightSelectable
@export var multi_meshinstance: MultiMeshInstance3D

@export var SIZE = 1:
	set(value):
		SIZE = value
		if Engine.is_editor_hint():
			load_curve()
@export var NUM_POINTS = 32:
	set(value):
		NUM_POINTS = value
		if Engine.is_editor_hint():
			load_curve()

var move_length: float
var moves_per_place: int


func _ready() -> void:
	multi_meshinstance.multimesh = multi_meshinstance.multimesh.duplicate()
	curve = Curve3D.new()
	load_curve()
	left_select.select = push_right
	right_select.select = push_left
	path_follow.progress -= path_follow.progress
	move_length = curve.get_baked_length() / (curve.point_count - 1)
	moves_per_place = curve.point_count / 8

func load_curve():
	curve.clear_points()

	multi_meshinstance.multimesh.instance_count = NUM_POINTS
	for i in NUM_POINTS:
		curve.add_point(Vector3(0, 0, -SIZE).rotated(Vector3.UP, (i / float(NUM_POINTS)) * TAU))
		var t: Transform3D = Transform3D()
		t.origin = curve.get_point_position(i)
		multi_meshinstance.multimesh.set_instance_transform(i, t)
	# End the circle.
	curve.add_point(Vector3(0, 0, -SIZE))


func push_right():
	left_select.can_be_selected = false
	right_select.can_be_selected = false
	await create_tween().tween_property(path_follow, "progress", path_follow.progress + (move_length * moves_per_place), 0.5).finished
	left_select.can_be_selected = true
	right_select.can_be_selected = true

func push_left():
	left_select.can_be_selected = false
	right_select.can_be_selected = false
	await create_tween().tween_property(path_follow, "progress", path_follow.progress - (move_length * moves_per_place), 0.5).finished
	left_select.can_be_selected = true
	right_select.can_be_selected = true
