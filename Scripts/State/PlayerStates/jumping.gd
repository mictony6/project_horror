extends PlayerState

var is_sprinting = false;

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	player.velocity.y -= (player.gravity * _delta);

	if is_sprinting:
		player.velocity.x = player.direction.x * (player.SPEED * 2)
		player.velocity.z = player.direction.z * (player.SPEED * 2)
	else:
		player.velocity.x = player.direction.x * player.SPEED
		player.velocity.z = player.direction.z * player.SPEED

	player.move_and_slide()

	if player.velocity.y <= 0:
		finished.emit(FALLING);

func enter(previous_state_path: String, data := {}) -> void:
	if Input.is_action_pressed("sprint"):
		is_sprinting = true;
	else:
		is_sprinting = false;

	player.velocity.y += player.JUMP_FORCE;


func exit() -> void:
	pass