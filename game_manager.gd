extends Node

signal score_updated

var game
var main
var score = 0
var high_score = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	main = get_node("/root/Main")
	game = main.get_node("ViewportContainer/Viewport/Game")
	
	change_scene("menu")

func add_score(points):
	score += points
	
	if score > high_score:
		high_score = score
	
	emit_signal("score_updated", score)

func reset_score():
	score = 0
	emit_signal("score_updated", score)

func change_scene(scene_name):
	game.change_scene(scene_name)
