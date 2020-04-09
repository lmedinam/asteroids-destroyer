extends KinematicBody2D

var speed = 55.0
var direction = Vector2(0, 0)

var viewport_size

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_size = get_viewport_rect().size
	$Position2D.position = direction.normalized()

func _process(delta):
	$Sprite.rotation_degrees = rad2deg($Sprite.position.angle_to_point($Position2D.position))
	
	if (position.x > viewport_size.x + 16):
		position = Vector2(0, position.y)
	if (position.x < -16):
		position = Vector2(viewport_size.x, position.y)
	
	if (position.y > viewport_size.y + 16):
		position = Vector2(position.x, 0)
	if (position.y < -16):
		position = Vector2(position.x, viewport_size.y)
	
	move_and_collide($Position2D.position * speed * delta)

func destroy():
	queue_free()

func _on_timer_timeout():
	destroy()
