extends Node2D

const scenes = {
	"level": "res://level.tscn",
	"menu": "res://menu.tscn"
}

var actual_scene

func _process(delta):
	var aim = get_viewport().get_mouse_position() / OS.window_size * Vector2(256, 240)
	$Cursor.position = aim

func change_scene(scene_name):
	if actual_scene != null:
		remove_child(actual_scene)
		actual_scene.call_deferred("free")
	
	var scene_resource = load(scenes[scene_name])
	actual_scene = scene_resource.instance()
	add_child(actual_scene)
