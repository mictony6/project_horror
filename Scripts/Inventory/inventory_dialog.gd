extends PanelContainer
class_name InventoryDialog

@onready var inventory_grid: GridContainer = %InventoryGrid
@export var slot_scene: PackedScene

var is_opened = false

func _ready() -> void:
	hide()

func open(inventory: Inventory):
	is_opened = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	show()
	for child in inventory_grid.get_children():
		child.queue_free()
	for item in inventory.get_items():
		var slot = slot_scene.instantiate()
		inventory_grid.add_child(slot)
		slot.set_item_to_display(item)

func close():
	is_opened = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hide()


func _on_close_button_pressed() -> void:
	close()
