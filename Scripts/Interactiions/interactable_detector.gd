extends Area3D
class_name InteractableDetector

var _interactables: Array[InteractionArea] = []
@export var interaction_prompt: Control
@onready var label: Label
@export var can_interact: bool = true


var last_label_position: Vector2

func _ready() -> void:
	interaction_prompt.hide()
	label = interaction_prompt.get_child(0).get_child(1)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact and _interactables.size() > 0:
		can_interact = false
		interaction_prompt.hide()
		await _interactables[0]._interaction.call()
		
		can_interact = true

func _process(delta: float) -> void:
	_interactables.sort_custom(sort_by_distance)


	if can_interact and _interactables.size() > 0:
		interaction_prompt.show()
		label.text = _interactables[0].interaction_name


		var camera = get_viewport().get_camera_3d()
		if camera.is_position_behind(_interactables[0].global_position):
			interaction_prompt.hide()
			return

		interaction_prompt.global_position = camera.unproject_position(_interactables[0].global_position)
		interaction_prompt.global_position.x -= interaction_prompt.size.x / 2

		var viewport_size = get_viewport().size
		interaction_prompt.global_position.x = clampf(interaction_prompt.global_position.x, 0, viewport_size.x - interaction_prompt.size.x)
		interaction_prompt.global_position.y = clampf(interaction_prompt.global_position.y, 0, viewport_size.y - interaction_prompt.size.y)


	else:
		interaction_prompt.hide()


func _on_area_entered(area: Area3D) -> void:
	if area is InteractionArea:
		if area.is_interactable:
			_interactables.push_back(area)


func _on_area_exited(area: Area3D) -> void:
	_interactables.erase(area)

func sort_by_distance(areaA: Area3D, areaB: Area3D) -> bool:
	var distanceA = global_position.distance_squared_to(areaA.global_position)
	var distanceB = global_position.distance_squared_to(areaB.global_position)
	return distanceA < distanceB
