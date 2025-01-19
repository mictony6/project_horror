extends Area3D
class_name Selectable

var can_be_selected: bool = true
@export var interaction_name: String
@export var secondary_interaction_name: String
var mesh_instance: MeshInstance3D
var material_overlay: Material
@onready var input_prompt: VBoxContainer = $InputPrompt
@onready var label: Label
var select: Callable = (func(): pass )


func _ready() -> void:
	label = input_prompt.get_node("Label")
	label.text = interaction_name
	input_prompt.hide()
	material_overlay = load("res://Material/ObjectHighlightOverlay.tres")

func _process(delta: float) -> void:
	if is_visible_in_tree() and can_be_selected:
		var camera = get_viewport().get_camera_3d()
		if camera.is_position_behind(global_position):
			unhighlight()
			return

		var screen_position = camera.unproject_position(global_position)
		screen_position.x -= input_prompt.size.x / 2
		screen_position.y -= input_prompt.size.y

		input_prompt.global_position = screen_position


func highlight() -> void:
	if !can_be_selected:
		return
	input_prompt.show()
	mesh_instance.material_overlay = material_overlay

func unhighlight() -> void:
	input_prompt.hide()
	mesh_instance.material_overlay = null

func switch_interaction_label() -> void:
	if label.text == interaction_name:
		label.text = secondary_interaction_name
	else:
		label.text = interaction_name