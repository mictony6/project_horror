extends CanvasLayer


@onready var inventory_dialog: InventoryDialog = %InventoryDialog
@onready var general_menu: Control = $GeneralMenu
func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS
	general_menu.hide()

func _unhandled_input(event: InputEvent) -> void:
	if !GlobalVariables.player: return
	if event.is_action_pressed("inventory"):
		if inventory_dialog.is_opened:
			general_menu.hide()
			inventory_dialog.close()
		elif GlobalVariables.can_open_inventory:
			general_menu.show()
			inventory_dialog.open(GlobalVariables.inventory)
