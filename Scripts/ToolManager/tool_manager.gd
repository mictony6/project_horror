extends Node3D
class_name ToolManager
@export var item_held: Item
@onready var player: Player = get_parent().get_parent()

func _ready() -> void:
	GlobalEventManager.item_used.connect(hold_item)
	process_mode = Node.PROCESS_MODE_ALWAYS


func hold_item(id: int):
	if get_child_count() > 0:
		get_child(0).queue_free()
	var item: Item = player.inventory.get_items()[id]
	item_held = item
	var scene = item.scene.instantiate()
	add_child(scene)
