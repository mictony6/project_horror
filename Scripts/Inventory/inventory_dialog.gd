extends PanelContainer
class_name InventoryDialog

@onready var inventory_grid: GridContainer = %InventoryGrid
@export var slot_scene: PackedScene

var is_opened = false

func _ready() -> void:
	close()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func open(inventory: Inventory):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	is_opened = true
	show()
	for child in inventory_grid.get_children():
		child.queue_free()

	var index = 0
	print(inventory.get_items())
	for item in inventory.get_items():
		var slot: ItemSlot = slot_scene.instantiate()
		inventory_grid.add_child(slot)
		slot.set_item_to_display(item, index)
		index += 1

	get_tree().paused = true

func close():
	is_opened = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hide()

	get_tree().paused = false


func _on_close_button_pressed() -> void:
	close()
