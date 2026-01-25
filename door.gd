extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Skeleton":
		%Timer.start()


func _on_timer_timeout() -> void:
	%Win_screen.visible = true
	get_tree().paused = true
