extends Control

func _ready():
	if rand_range(0, 100) < 5:
		$Header/ContentContainer/FullscreenWrapper/Label.text = "F to pay respects"

func _input(event):
	if event.is_action_pressed("ui_accept"):
		GameManager.change_scene("level")
