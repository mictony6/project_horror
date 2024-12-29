extends Node3D
class_name Head

var MOUSE_SENSITIVITY = 0.25
var MOUSE_X_SENSITIVITY = 1.0
var MOUSE_Y_SENSITIVITY = 0.5

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * (MOUSE_SENSITIVITY * MOUSE_X_SENSITIVITY)
		rotation_degrees.x = clampf(rotation_degrees.x, -90.0, 75)
		rotation_degrees.y -= event.relative.x * (MOUSE_SENSITIVITY * MOUSE_Y_SENSITIVITY)
