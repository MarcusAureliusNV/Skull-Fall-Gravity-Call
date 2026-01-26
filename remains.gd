extends Area2D

func _on_body_entered(body: Node2D):
	# 1. Check if the body is a Tomb
	if body.is_in_group("Tombs"):	# If a tomb touches the dead skeletons (Remains)
		var timer = body.get_node("TombTimer") # Gets the tomb's timer and starts it
		timer.start()
