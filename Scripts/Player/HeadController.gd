extends Node3D
class_name Head

var MOUSE_SENSITIVITY = 0.25
var MOUSE_X_SENSITIVITY = 1.0
var MOUSE_Y_SENSITIVITY = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * (MOUSE_SENSITIVITY * MOUSE_X_SENSITIVITY)
		rotation_degrees.x = clampf(rotation_degrees.x, -90.0, 75)
		rotation_degrees.y -= event.relative.x * (MOUSE_SENSITIVITY * MOUSE_Y_SENSITIVITY)
		# rotation_degrees.y = clampf(rotation_degrees.y, 0.0, 360.0)
