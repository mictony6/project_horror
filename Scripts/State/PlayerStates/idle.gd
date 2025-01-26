extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.velocity.y -= (player.gravity * _delta);
	player.move_and_slide()
	

	if not player.is_on_floor():
		finished.emit(FALLING);
	else:
		if Input.is_action_just_pressed("jump"):
			finished.emit(JUMPING);
		elif Input.is_action_just_pressed("crouch"):
			finished.emit(CROUCH)
		elif player.direction.x or player.direction.z:
			finished.emit(WALKING);

	
func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0;
	player.velocity.z = 0;

func exit() -> void:
	pass