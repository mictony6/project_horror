extends Node
signal item_used(id: int)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS