extends Node2D

const scenes = {
	"level": "res://level.tscn",
	"menu": "res://menu.tscn",
	"game_over": "res://game_over.tscn"
}

var actual_scene

func _ready():
	GameManager.connect("score_updated", self, "_update_score")
	_update_score(GameManager.score)

func _process(delta):
	var aim = get_viewport().get_mouse_position() / OS.window_size * Vector2(256, 240)
	$Cursor.position = aim

func _update_score(new_score):
	$HUD/Score/Points.text = "%07d" % new_score
	$HUD/HighScore/Points.text = "%07d" % GameManager.high_score

func change_scene(scene_name):
	if actual_scene != null:
		remove_child(actual_scene)
		actual_scene.call_deferred("free")
	
	var scene_resource = load(scenes[scene_name])
	actual_scene = scene_resource.instance()
	add_child(actual_scene)
