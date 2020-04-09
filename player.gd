extends "res://rigid_entity.gd"

signal die

const SPEED = 0.5
const ROTATION_SPEED = 2.0

var can_shoot = true

func _input(event):
	if event.is_action_pressed("ui_accept") and can_shoot:
		shoot()

func _process(delta):
	var aim =  get_viewport().get_mouse_position() / OS.window_size * Vector2(256, 240)
	var look_at = position.angle_to(aim)
	
	$Sprite.look_at(aim)

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
	can_shoot = false
	$ShootDelay.start()
	
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
	
	emit_signal("die")
	
	queue_free()

func _on_shoot_delay_timeout():
	can_shoot = true
