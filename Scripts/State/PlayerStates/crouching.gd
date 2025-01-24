extends PlayerState

@export var animation_player: AnimationPlayer
@onready var raycast: RayCast3D = %CheckCanStand
## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	player.velocity.x = player.direction.x * player.SPEED;
	player.velocity.z = player.direction.z * player.SPEED;
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING);
	elif Input.is_action_just_pressed("crouch"):
		raycast.force_raycast_update()
		if !raycast.is_colliding():
			finished.emit(IDLE);


## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	animation_player.play("crouch_down")

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	animation_player.play("stand_up")
