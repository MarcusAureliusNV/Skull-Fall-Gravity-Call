extends RigidBody2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node) -> void:
	# Freezing mechanic so the game is actually beatable
	if body.is_in_group("Remains"):
		if timer.is_stopped() and not freeze:
			timer.start() # Starts tombtimer

func _on_timer_timeout() -> void:
	freeze = true
	
	# update score
	var game = get_tree().root.get_node("Game")
	if game.has_method("add_point"):
		game.add_point()

func grav_to(elec):
	if freeze:
		return
	elif not freeze:
		if elec == "down": rotation_degrees = 0
		elif elec == "up": rotation_degrees = 180
		elif elec == "right": rotation_degrees = -90
		elif elec == "left": rotation_degrees = 90
