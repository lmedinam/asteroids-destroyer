extends RigidBody2D

func _integrate_forces(state):
	var viewport_size = get_viewport_rect().size
	var transform = state.get_transform()
	
	if (transform.origin.x > viewport_size.x + 16):
		transform.origin = Vector2(0, transform.origin.y)
	if (transform.origin.x < -16):
		transform.origin = Vector2(viewport_size.x, transform.origin.y)
	
	if (transform.origin.y > viewport_size.y + 16):
		transform.origin = Vector2(transform.origin.x, 0)
	if (transform.origin.y < -16):
		transform.origin = Vector2(transform.origin.x, viewport_size.y)
	
	state.set_transform(transform)