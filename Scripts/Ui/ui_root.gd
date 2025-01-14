extends CanvasLayer


@onready var player: Player = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog
func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		if inventory_dialog.is_opened:
			inventory_dialog.close()
		elif GlobalVariables.can_open_inventory:
			inventory_dialog.open(player.inventory)
