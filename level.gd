extends Node2D

enum {UP, DOWN, LEFT, RIGHT}

const ASTEROID_BIG = preload("res://asteroid_big.tscn")
const ASTEROID_MEDIUM = preload("res://asteroid_medium.tscn")

var viewport_size
var random

func _ready():
	random = RandomNumberGenerator.new()
	viewport_size = get_viewport_rect().size
	
	for i in range(0, 6):
		spawn_random_asteroid()
	
func spawn_random_asteroid():
	spawn_asteroid(random.randi_range(0, 4))

func spawn_asteroid(from):
	random.randomize()
	
	var asteroid = ASTEROID_BIG.instance()
	var position = Vector2(0, 0)
	
	if (from == UP or from == DOWN):
		position.x = random.randi_range(0, viewport_size.x)
		
	if (from == LEFT or from == RIGHT):
		position.y = random.randi_range(0, viewport_size.y)
	
	if (from == DOWN):
		position.y = viewport_size.y
	elif (from == RIGHT): 
		position.x = viewport_size.x
	
	asteroid.position = position
	asteroid.apply_impulse(Vector2(), asteroid._random_vec2(-24, 24))
	
	add_child(asteroid)

func _on_timer_timeout():
	if (randf() < 0.25):
		spawn_random_asteroid()
