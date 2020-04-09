extends Control

func _input(event):
	if event.is_action_pressed("ui_accept"):
		GameManager.change_scene("menu")
