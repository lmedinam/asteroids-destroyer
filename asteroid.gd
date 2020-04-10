tool
extends "res://rigid_entity.gd"

export(int) var collision_radius
export(int) var spawn_at_destroy
export(PackedScene) var spawn_scene

onready var Player = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Yes, we need a new instace of a circle shape in each object
	# Because in the other way will be shared
	var circle_shape = CircleShape2D.new()
	$Area2D/CollisionShape2D.shape = circle_shape
	
	# And then set the shape size
	_set_collision_shape_radius()
	
	set_angular_velocity(rand_range(-0.5, 0.5))

func _process(delta):
	if Engine.editor_hint:
		_set_collision_shape_radius()

func _set_collision_shape_radius():
	if ($Area2D/CollisionShape2D.shape):
		$Area2D/CollisionShape2D.shape.radius = collision_radius

func _on_area_2d_body_entered(body):
	var particles = preload("res://particles.tscn").instance()
	
	SoundsManager.play("explosion", -5)
	
	if (body.has_method("kill")):
		body.kill()
	
	if (body.get("direction") != null):
		apply_impulse(Vector2(), body.direction)
	
	if (body.has_method("destroy") and not body.has_method("kill")):
		particles.position = position
		get_parent().add_child(particles)
		particles.shoot()
		
		body.destroy()
		
		if (spawn_at_destroy > 0):
			if (body.get("direction") != null):
				call_deferred("_spawn_asteroids", body.direction)
		
		GameManager.add_score(50)
		
		queue_free()

func _spawn_asteroids(impulse):
	for i in range(0, spawn_at_destroy):
		var scene = spawn_scene.instance()
		
		scene.position = position + _random_vec2(-8, 8)
		
		scene.apply_impulse(Vector2(), linear_velocity + impulse)
		scene.apply_impulse(Vector2(), _random_vec2(-16, 16))
		
		get_parent().add_child(scene)

func _random_vec2(minv, maxv):
	var random = RandomNumberGenerator.new()
	random.randomize()
	return Vector2(random.randi_range(minv, maxv), random.randi_range(minv, maxv))