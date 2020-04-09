extends Control

func _ready():
	GameManager.save_game()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		GameManager.reset_score()
		GameManager.change_scene("menu")
