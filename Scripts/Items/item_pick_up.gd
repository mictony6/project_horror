@tool
extends Node3D
class_name ItemPickUp

@export var item: Item;
var item_child;
var default_pos: Vector3;
@onready var interaction_area: InteractionArea = $InteractionArea

func _ready() -> void:
	if item:
		item_child = item.scene.instantiate();
		add_child(item_child);
	interaction_area._interaction = handle_interaction
	if not Engine.is_editor_hint():
		default_pos = position;
		bob()
	
func handle_interaction():
	GlobalVariables.player.inventory.add_item(item);
	queue_free()

func bob():
	#make the iten bob up and down
	var tween: Tween = get_tree().create_tween().set_loops().bind_node(self).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", default_pos + Vector3(0, .1, 0), 1.0);
	tween.tween_property(self, "position", default_pos - Vector3(0, 0.1, 0), 1.0);
