extends Node3D
class_name Head

@export var first_person_cam: Camera3D
@export var third_person_cam: Camera3D
var _current_camera: Camera3D

var last_global_position: Vector3 = Vector3.ZERO
var camera_velocity: Vector3 = Vector3.ZERO

@export var HEAD_BOB_INTENSITY = 1.0
@export var HEAD_BOB_SPEED = 10.0
var t_bob: float = 0.0
@export var bob_curve: Curve
var default_camera_y: float

var MOUSE_SENSITIVITY = 0.25
var MOUSE_X_SENSITIVITY = 0.5
var MOUSE_Y_SENSITIVITY = 0.75

var can_rotate = true

# Target rotation for smoothing
var target_rotation: Vector3 = Vector3.ZERO

# Smoothing factor (0.0 to 1.0, where 1.0 is no smoothing)
@export var smoothing_factor: float = 0.5


func _ready() -> void:
	_current_camera = first_person_cam
	default_camera_y = first_person_cam.position.y

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and can_rotate:
		var x_rot = event.relative.y * (MOUSE_SENSITIVITY * MOUSE_X_SENSITIVITY)
		var y_rot = event.relative.x * (MOUSE_SENSITIVITY * MOUSE_Y_SENSITIVITY)

		# Update target rotation
		target_rotation.x -= x_rot
		target_rotation.y -= y_rot

		target_rotation.x = clampf(target_rotation.x, -90.0, 75)
	elif event is InputEventKey:
		if event.keycode == KEY_F5 and event.is_pressed():
			switch_camera()

func _physics_process(delta: float) -> void:
	# Smoothly interpolate towards the target rotation
	rotation_degrees.x = lerpf(rotation_degrees.x, target_rotation.x, smoothing_factor)
	rotation_degrees.y = lerpf(rotation_degrees.y, target_rotation.y, smoothing_factor)

	# Apply head bobbing
	var is_sprinting = 1.5 if Input.is_action_pressed("sprint") else 1.0
	if Input.is_action_pressed("forward") or Input.is_action_pressed("backward"):
		t_bob += delta
		var t = sin(t_bob * (is_sprinting * HEAD_BOB_SPEED)) * HEAD_BOB_INTENSITY
		var bob_offset = bob_curve.sample(t)
		first_person_cam.position.y = lerpf(first_person_cam.position.y, default_camera_y + bob_offset, 0.1)
	else:
		first_person_cam.position.y = lerpf(first_person_cam.position.y, default_camera_y, 0.1)


func switch_camera():
	_current_camera.current = false
	match _current_camera:
		first_person_cam:
			_current_camera = third_person_cam
		third_person_cam:
			_current_camera = first_person_cam
	_current_camera.current = true
