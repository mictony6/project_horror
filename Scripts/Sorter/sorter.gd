extends Node3D
class_name Sorter

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sorter_ui: CanvasLayer = $SorterUI
@onready var contents: HBoxContainer = %Slots
@export var sorter_id: String = "sorter_1"
@export var empty_cd: Item
var num_of_slots: int

var last_arrangement = {}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	interaction_area._interaction = handle_interaction

	num_of_slots = contents.get_child_count()


func update_contents() -> void:
	var cd_items: Array[Item] = []
	for item in GlobalVariables.player.inventory.get_items():
		if item.sorter_key == sorter_id:
			cd_items.append(item)

	# Use saved arrangement if available
	if not last_arrangement.is_empty():
		# Sort using item name
		cd_items.sort_custom(func(a, b):
			return last_arrangement.get(a.name, 999) < last_arrangement.get(b.name, 999)
		)

	# Update slots
	for i in range(num_of_slots):
		var cd_slot: CdSlot = contents.get_child(i)
		if i < cd_items.size():
			cd_slot.set_item(cd_items[i])
		else:
			cd_slot.set_item(empty_cd)

func save_current_arrangement() -> void:
	last_arrangement.clear()
	for i in range(num_of_slots):
		var cd_slot: CdSlot = contents.get_child(i)
		var item = cd_slot.item
		if item != empty_cd:
			# Store position using item name or another identifying property
			last_arrangement[item.name] = i

func handle_interaction():
	open_sorter_ui()

func _on_close_button_pressed() -> void:
	save_current_arrangement()
	close_sorter_ui()

func open_sorter_ui():
	GlobalVariables.can_open_inventory = false
	update_contents()
	sorter_ui.show()
	interaction_area.is_interactable = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true

func close_sorter_ui():

	GlobalVariables.can_open_inventory = true
	get_tree().paused = false
	interaction_area.is_interactable = true
	sorter_ui.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
