extends Node3D

@onready var switch_selectable: Selectable = $AnimatableBody3D/Switch/Selectable
@onready var body: AnimatableBody3D = $AnimatableBody3D
# Called when the node enters the scene tree for the first time.

var body_rotations = []
var rot_idx = 0
func _ready() -> void:
	switch_selectable.select = rotate_room
	switch_selectable.mesh_instance = $AnimatableBody3D/Switch/Mesh
	body_rotations.append(body.rotation.y)
	body_rotations.append(body.rotation.y + (PI * 0.5))
	body_rotations.append(body.rotation.y + PI)
	body_rotations.append(body.rotation.y + (PI * 1.5))
	

func rotate_room():
	rot_idx += 1
	rot_idx %= body_rotations.size()
	var tween: Tween = create_tween()

	var target_rotation = body_rotations[rot_idx]
	target_rotation = lerp_angle(body.rotation.y, target_rotation, 1)

	switch_selectable.can_be_selected = false
	await tween.tween_property(body, "rotation", Vector3(body.rotation.x, target_rotation, body.rotation.z), 0.5).finished
	body.rotation.y = target_rotation
	await get_tree().create_timer(0.1).timeout
	switch_selectable.can_be_selected = true
