extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:

	player.velocity.x = player.direction.x * player.SPEED;
	player.velocity.z = player.direction.z * player.SPEED;
	player.move_and_slide()


	if not player.is_on_floor():
		finished.emit(FALLING);
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING);
	elif Input.is_action_pressed("sprint"):
		finished.emit(SPRINTING);
	elif Input.is_action_just_pressed("crouch"):
		finished.emit(CROUCH)
	elif player.direction.is_equal_approx(Vector3.ZERO):
		finished.emit(IDLE);

func enter(previous_state_path: String, data := {}) -> void:
	pass

func exit() -> void:
	pass
