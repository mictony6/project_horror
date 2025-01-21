extends Node
signal item_used(id: int)
signal disk_inserted(disk: DiskItem)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS