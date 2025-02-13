extends Node
signal item_ui_select(id: int)
signal disk_inserted(disk: DiskItem)
signal item_pickup(item: Item)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS