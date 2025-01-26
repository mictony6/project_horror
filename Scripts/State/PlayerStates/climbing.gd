extends PlayerState

## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:

	player.climb_raycast.force_raycast_update()
	if player.climb_raycast.is_colliding():
		var roty = -(atan2(player.climb_raycast.get_collision_normal().z, player.climb_raycast.get_collision_normal().x) - PI / 2)
		player.climb_raycast.global_rotation.y = roty
		
		var climbing_direction: Vector3
		var h_input = Input.get_axis("left", "right");
		var f_input = Input.get_axis("backward", "forward");

		var rot = -(atan2(player.climb_raycast.get_collision_normal().z, player.climb_raycast.get_collision_normal().x) - PI / 2)
		climbing_direction = Vector3(h_input, f_input, 0).rotated(Vector3.UP, rot).normalized()
			
		player.velocity = climbing_direction * player.CLIMB_SPEED * 0.5;
	else:
		finished.emit(FALLING)

	player.move_and_slide()

	if Input.is_action_just_pressed("jump") and !player.head_raycast.is_colliding():
		finished.emit(JUMPING)

func enter(previous_state_path: String, data := {}) -> void:
	player.climb_raycast.global_rotation.y = -(atan2(player.head_raycast.get_collision_normal().z, player.head_raycast.get_collision_normal().x) - PI / 2)
	

func exit() -> void:
	pass
	

func get_num_rays_colliding(rays: Array):
	var sum = 0
	for ray in rays:
		ray.force_raycast_update()
		if ray.is_colliding() and ray.get_collider().is_in_group("Climbable"):
			sum += 1
	return sum
