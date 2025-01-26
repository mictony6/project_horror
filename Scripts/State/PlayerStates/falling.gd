extends PlayerState
var velocity_on_enter: Vector3

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	player.velocity.x = player.velocity.x;
	player.velocity.z = player.velocity.z;
	player.velocity.y -= (player.gravity * _delta)
	player.move_and_slide();

	if player.can_climb():
		finished.emit(CLIMB)
		return

	if player.is_on_floor():
		finished.emit(IDLE);


func enter(previous_state_path: String, data := {}) -> void:
	velocity_on_enter = player.velocity


func exit() -> void:
	pass