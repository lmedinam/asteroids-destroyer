extends Node

var game
var main

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	main = get_node("/root/Main")
	game = main.get_node("ViewportContainer/Viewport/Game")
	
	change_scene("menu")

func change_scene(scene_name):
	game.change_scene(scene_name)
