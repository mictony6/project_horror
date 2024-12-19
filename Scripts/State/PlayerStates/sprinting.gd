extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	player.velocity.x = player.direction.x * player.SPRINT_SPEED;
	player.velocity.z = player.direction.z * player.SPRINT_SPEED;
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING);
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING, {"is_sprinting": true});
	elif Input.is_action_just_released("sprint"):
		finished.emit(WALKING);
	elif player.direction.is_equal_approx(Vector3.ZERO):
		finished.emit(IDLE);

func enter(previous_state_path: String, data := {}) -> void:
	pass

func exit() -> void:
	pass