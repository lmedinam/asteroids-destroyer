extends "res://rigid_entity.gd"

const SPEED = 0.5
const ROTATION_SPEED = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		shoot()

func _process(delta):
	var look_at = $Sprite.get_local_mouse_position()
	$Sprite.rotation += look_at.angle() * 0.1

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
        apply_impulse(Vector2(), Vector2(1, 0) * SPEED)
	if Input.is_action_pressed("ui_left"):
        apply_impulse(Vector2(), Vector2(-1, 0) * SPEED)
	if Input.is_action_pressed("ui_up"):
        apply_impulse(Vector2(), Vector2(0, -1) * SPEED)
	if Input.is_action_pressed("ui_down"):
        apply_impulse(Vector2(), Vector2(0, 1) * SPEED)

func shoot():
	var bullet = preload("res://bullet.tscn").instance()
	var cannon_position = $Sprite/Cannon.get_global_position()
	
	bullet.position = cannon_position
	bullet.direction = cannon_position - position
	
	get_parent().add_child(bullet)

func kill():
	var particles = preload("res://particles.tscn").instance()
	particles.position = position
	get_parent().add_child(particles)
	particles.shoot()
	
	queue_free()
