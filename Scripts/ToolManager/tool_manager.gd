class_name ToolManager extends Node3D

@onready var right_hand: Marker3D = $RightHand

var _item_equipped: Item

func _ready() -> void:
	GlobalEventManager.disk_inserted.connect(_on_disk_inserted)
	GlobalEventManager.item_ui_select.connect(_on_item_ui_select)

func equip_tool(item: Item):
	if has_tool_equpped():
		unequip_tool()

	
	var tool_scene: Node3D = item.scene.instantiate()
	tool_scene.position = item.position
	tool_scene.rotation = item.rotation


	right_hand.add_child(tool_scene)
	_item_equipped = item
	_item_equipped.is_equipped = true

func unequip_tool():
	_item_equipped.is_equipped = false
	_item_equipped = null
	for child in right_hand.get_children():
		child.queue_free()

func use_tool():
	if has_tool_equpped():
		var tool_equipped: Node3D = right_hand.get_child(0)
		if tool_equipped.is_in_group("Usable"):
			tool_equipped.use()
	

func has_tool_equpped():
	return _item_equipped != null

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			use_tool()

func _on_item_ui_select(id: int):
	if id < 0 and has_tool_equpped():
		unequip_tool()
		return
	var item: Item = GlobalVariables.inventory.get_item(id)
	if item == null:
		printerr("Index out of range")
		return
	equip_tool(item)

func _on_disk_inserted(_disk: DiskItem):
	unequip_tool()