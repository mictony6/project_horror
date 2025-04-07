extends PlayerState
var velocity_on_enter: Vector3
var buffered_jump_timer: float = 0.0
var buffered_jump_time: float = 0.2


func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_pressed("jump"):
		buffered_jump_timer = buffered_jump_time
	
	buffered_jump_timer -= _delta
	
func physics_update(_delta: float) -> void:
	player.velocity.x = player.velocity.x;
	player.velocity.z = player.velocity.z;
	player.velocity.y -= (player.gravity * _delta)
	player.move_and_slide();

	if player.can_climb():
		finished.emit(CLIMB)
		return

	if player.is_on_floor():
		if buffered_jump_timer > 0.0:
			finished.emit(JUMPING)
		else:
			finished.emit(IDLE);


func enter(previous_state_path: String, data := {}) -> void:
	velocity_on_enter = player.velocity


func exit() -> void:
	pass