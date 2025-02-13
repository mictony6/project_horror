extends CharacterBody3D
class_name Player

# Raycasts
@onready var climb_raycast: RayCast3D = $CheckCanClimb
@onready var head_raycast: RayCast3D = $HeadRayCast

# Movement variables
const SPEED: int = 2;
const SPRINT_SPEED: int = 3;
const JUMP_FORCE = 4;
const CLIMB_SPEED: int = 1;
var direction: Vector3 = Vector3.ZERO;
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity");
# Components
@export var head: Head
@onready var flashlight: Flashlight = $Head/Flashlight
@onready var inventory: Inventory = GlobalVariables.inventory
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GlobalVariables.player = self;
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		if event.keycode == KEY_F:
			flashlight.toggle();
		if event.keycode == KEY_F11:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN


func _process(_delta: float) -> void:
	head_raycast.global_rotation.y = head.global_rotation.y

	var h_movement = Input.get_axis("left", "right");
	var z_movement = Input.get_axis("backward", "forward");
	direction.x = h_movement;
	direction.z = -z_movement;


	# make direction relative to camera
	direction = direction.rotated(Vector3.UP, head.global_rotation.y);
	direction = direction.normalized();


func can_climb():
	if head_raycast.is_colliding():
		var collider = head_raycast.get_collider()
		if collider.is_in_group("Climbable"):
			
			var normal: Vector3 = head_raycast.get_collision_normal()
			var angle = rad_to_deg(normal.angle_to(Vector3(0, -1, 0)))
			return angle > 70 and angle < 120
