extends Node3D

@onready var switch_selectable: Selectable = $AnimatableBody3D/Switch/Selectable
@onready var body: AnimatableBody3D = $AnimatableBody3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_selectable.select = rotate_room
	switch_selectable.mesh_instance = $AnimatableBody3D/Switch/Mesh


func rotate_room():
	var tween: Tween = create_tween()
	var target_rotation = body.rotation.y + (PI / 2)
	switch_selectable.can_be_selected = false
	await tween.tween_property(body, "rotation", Vector3(body.rotation.x, target_rotation, body.rotation.z), 0.5).finished
	switch_selectable.can_be_selected = true
