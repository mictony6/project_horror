extends Node3D
class_name ToolManager
@onready var player: Player = get_parent().get_parent()
@export var animation_player: AnimationPlayer
var item_held: Item

func _ready() -> void:
	GlobalEventManager.item_used.connect(hold_item)
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and is_holding_item():
		use_held_item()


func hold_item(id: int):
	if is_holding_item():
		item_held = null
		get_child(0).queue_free()
	var item: Item = player.inventory.get_items()[id]
	var scene = item.scene.instantiate()
	item_held = item
	add_child(scene)

func use_held_item():
	animation_player.queue("use_item")


func is_holding_item() -> bool:
	return get_child_count() > 0