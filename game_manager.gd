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
	
	load_game()
	
	change_scene("menu")

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

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

func save_game():
	var game_save = File.new()
	
	game_save.open("user://game.save", File.WRITE)
	game_save.store_line(to_json({"high_score": score}))
	
	game_save.close()

func load_game():
	var game_save = File.new()
	
	if not game_save.file_exists("user://game.save"):
		return
	
	game_save.open("user://game.save", File.READ)
	var result = JSON.parse(game_save.get_line()).result
	
	high_score = result['high_score']
	emit_signal("score_updated", score)
