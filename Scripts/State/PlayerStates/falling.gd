extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	player.velocity.x = player.direction.x * player.SPEED;
	player.velocity.z = player.direction.z * player.SPEED;
	player.velocity.y -= (player.gravity * _delta)
	player.move_and_slide();

	if player.is_on_floor():
		if player.direction.is_equal_approx(Vector3.ZERO):
			finished.emit(IDLE);
		elif Input.is_action_pressed("sprint"):
			finished.emit(SPRINTING);
		else:
			finished.emit(WALKING);

func enter(previous_state_path: String, data := {}) -> void:
	pass

func exit() -> void:
	pass