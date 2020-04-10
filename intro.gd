extends Control

func _ready():
	SoundsManager.play("intro", -10.0)

func _on_change_delay_timeout():
	GameManager.change_scene("menu")
