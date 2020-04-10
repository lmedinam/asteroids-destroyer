extends Node

var resources = {
	"explosion": "res://explosion.ogg",
	"game_over": "res://game_over.ogg",
	"shoot": "res://shoot.ogg",
	"intro": "res://intro.ogg"
}

func play(resource_name, volume_db = 0) -> void:
	var stream = load(resources[resource_name])
	stream.set_loop(false)
	
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.connect("finished", self, "_remove_player", [player])
	player.volume_db = volume_db
	player.stream = stream
	player.play(0.0)
	
	GameManager.main.call_deferred("add_child", player)

func _remove_player(node: Node) -> void:
	GameManager.main.call_deferred("remove_child", node)
	node.queue_free()
