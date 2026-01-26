extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Skeleton":
		%Timer.start()	# If the player touches the door, it isn't instant win so it's more inmersive


func _on_timer_timeout() -> void:
	%Win_screen.visible = true	# Shows a win screen with buttons
	%VictorySound.play()	# Plays a sound when the screen shows
	get_tree().paused = true	# Pauses the game so everything stops behind the win screen
