class_name Conductive extends Area3D
		
signal on_power_on
signal on_power_off

var is_source: bool = false
var is_active: bool = false:
	get():
		if is_source:
			is_active = true
			return true
		else:
			return is_active # Whether this conductive node is powered
var connected_conductors: Array[Conductive] = [] # List of conductive objects it touches


func _ready():
	connect("area_entered", _on_conductor_entered)
	connect("area_exited", _on_conductor_exited)
	if is_source:
		activate()

func _on_conductor_entered(area: Conductive):
	connected_conductors.append(area)
	update_power_state()

func _on_conductor_exited(area: Conductive):
	if area in connected_conductors:
		connected_conductors.erase(area)
		update_power_state()

func activate():
	is_active = true
	for conductor in connected_conductors:
		conductor.update_power_state()
	on_power_on.emit()

func deactivate():
	is_active = false
	for conductor in connected_conductors:
		conductor.update_power_state()
	on_power_off.emit()

func update_power_state():
	if is_source:
		is_active = true
		return

	await get_tree().create_timer(0.1).timeout # Small delay to avoid processing overload
	
	var has_power = await check_if_powered()
	if is_active != has_power:
		is_active = has_power
		for conductor in connected_conductors:
			conductor.update_power_state()
	print(connected_conductors)
	

func check_if_powered(visited_nodes = []):
	await get_tree().process_frame # Wait a frame before checking power
	if is_source:
		return true # This node is always powered

	if self in visited_nodes:
		return false # Prevent infinite loops

	visited_nodes.append(self)

	for conductor in connected_conductors:
		if await conductor.check_if_powered(visited_nodes):
			return true # Found a valid path to power

	return false # No valid power source found

func _process(delta: float) -> void:
	if !get_viewport().get_camera_3d().is_position_behind(self.global_position):
		$Label.show()
		$Label.text = "On" if is_active else "Off"
		$Label.global_position = get_viewport().get_camera_3d().unproject_position(self.global_position)
	else:
		$Label.hide()