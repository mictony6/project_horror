extends Node3D
class_name Sorter


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sorter_ui: CanvasLayer = $SorterUI
@onready var contents: HBoxContainer = %Slots
@export var sorter_id: String = "sorter_1"
var num_of_slots: int

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	interaction_area._interaction = handle_interaction

	num_of_slots = contents.get_child_count()


func update_contents():
	# initialize contents based on player inventory
	# find all cd items in player inventory with the samne sorter_id

	var cd_items: Array[Item] = []
	for item in GlobalVariables.player.inventory.get_items():
		if item.sorter_key == sorter_id:
			cd_items.append(item)

	assert(cd_items.size() <= num_of_slots, "Number of CD items in player inventory exceeds the number of slots in the sorter")

	for i in range(cd_items.size()):
		var cd_display: CdSlot = contents.get_child(i)

		cd_display.set_item(cd_items[i])


func handle_interaction():
	open_sorter_ui()

func _on_close_button_pressed() -> void:
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
