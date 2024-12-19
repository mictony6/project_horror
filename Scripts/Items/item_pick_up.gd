@tool
extends Node3D
class_name ItemPickUp

@export var item: Item;
var item_child;
var default_pos: Vector3;


func _ready() -> void:

	item_child = item.scene.instantiate();
	add_child(item_child);
	if not Engine.is_editor_hint():
		default_pos = position;
		bob()

func _on_pickup_detector_body_entered(body: Node3D) -> void:
	if body is Player:
		body.on_item_pickup(item);
		queue_free();
func bob():
	#make the iten bob up and down
	var tween: Tween = get_tree().create_tween().set_loops().bind_node(self).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", default_pos + Vector3(0, .1, 0), 1.0);
	tween.tween_property(self, "position", default_pos - Vector3(0, 0.1, 0), 1.0);
