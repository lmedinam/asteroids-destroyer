extends CPUParticles2D

func shoot():
	emitting = true
	
	$Timer.wait_time = lifetime
	$Timer.start()

func _on_timer_timeout():
	queue_free()
