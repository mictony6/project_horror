@tool
extends Node3D
class_name ItemPickUp

@export var item: Item:
	set(value):
		item = value
		if Engine.is_editor_hint():
			load_item(value)

var item_default_position: Vector3
@onready var item_instance_holder: Node3D = %ItemInstanceHolder
@onready var interaction_area: InteractionArea = $InteractionArea

func _ready() -> void:
	load_item(item)
		
	interaction_area._interaction = handle_interaction
	if not Engine.is_editor_hint():
		item_default_position = position;
		bob()

func load_item(_item: Item):
	if item_instance_holder.get_child_count() > 0:
		for child in item_instance_holder.get_children():
			child.queue_free()
			
	var item_scene: Node3D = _item.scene.instantiate()
	item_instance_holder.add_child(item_scene)

func handle_interaction():
	GlobalEventManager.item_pickup.emit(self.item)
	queue_free()

func bob():
	#make the iten bob up and down
	var tween: Tween = get_tree().create_tween().set_loops().bind_node(self).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", item_default_position + Vector3(0, .1, 0), 1.0);
	tween.tween_property(self, "position", item_default_position - Vector3(0, 0.1, 0), 1.0);
