extends CanvasLayer


@onready var player: Player = %Player
@onready var inventory_dialog: InventoryDialog = %InventoryDialog

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("inventory"):
		if inventory_dialog.is_opened:
			inventory_dialog.close()
		else:
			inventory_dialog.open(player.inventory)
