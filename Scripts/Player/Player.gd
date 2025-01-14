extends CharacterBody3D
class_name Player

@export var head: Head
@onready var flashlight: Flashlight = $Head/Flashlight

var inventory: Inventory = Inventory.new();

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const SPEED: int = 2;
const SPRINT_SPEED: int = 4;
const JUMP_FORCE = 5;
var direction: Vector3 = Vector3.ZERO;


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GlobalVariables.player = self;


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_F:
			flashlight.toggle();
		if event.keycode == KEY_F11:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN


func _process(_delta: float) -> void:
	var h_movement = Input.get_axis("left", "right");
	var z_movement = Input.get_axis("backward", "forward");
	direction.x = h_movement;
	direction.z = -z_movement;


	# make direction relative to camera
	direction = direction.rotated(Vector3.UP, head.rotation.y);
	direction = direction.normalized();
