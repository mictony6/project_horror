extends RayCast3D
var last_colliding_body: Selectable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		var colliding_body: Selectable = get_collider()
		colliding_body.highlight()
		if last_colliding_body and last_colliding_body != colliding_body:
			last_colliding_body.unhighlight()
		last_colliding_body = colliding_body
	else:
		if last_colliding_body:
			last_colliding_body.unhighlight()
			last_colliding_body = null

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if last_colliding_body and last_colliding_body.can_be_selected:
				last_colliding_body.select.call()
