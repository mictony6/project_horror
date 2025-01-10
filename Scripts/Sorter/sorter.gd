extends Node3D
class_name Sorter

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sorter_ui: CanvasLayer = $SorterUI
var _contents: Dictionary = {}
@export var slots: int = 4


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in slots:
		_contents[i] = null

	interaction_area._interaction = handle_interaction
func display_contents():
	for i in range(slots):
		print("Slot ", i, ": ", _contents[i])

func add_vhs(item: Item, slot: int):
	_contents[slot] = item

func move_vhs(src: int, dest: int):
	var vhs = _contents[src]
	_contents[src] = null
	_contents[dest] = vhs

func handle_interaction():
	sorter_ui.show()
	interaction_area.is_interactable = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true


func _on_button_pressed() -> void:
	get_tree().paused = false
	interaction_area.is_interactable = true
	sorter_ui.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
