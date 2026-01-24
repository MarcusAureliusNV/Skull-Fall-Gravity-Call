extends RigidBody2D

@onready var timer: Timer = $Timer

# The tomb detects the floor zone itself
func _on_body_entered(body: Node) -> void:
	# if there are remains, freeze the tomb
	if body.is_in_group("Remains"):
		# Only start if we haven't frozen yet
		if timer.is_stopped() and not freeze:
			timer.start()
			print("Timer started for: ", name)

func _on_timer_timeout() -> void:
	# Freeze the physics
	freeze = true
	rotation_degrees = 0 
	print("Tomb frozen!")
	
	# Add point to the main game counter
	var game = get_tree().root.get_node_or_null("Game")
	if game and game.has_method("add_point"):
		game.add_point()

func grav_to(elec):
	# If we are frozen, do nothing. 
	# this prevents the tomb from rotating after it's locked in the hole
	if freeze == true:
		return
	else:
	# Simple rotation (includes collisions)
		if elec == "down": rotation_degrees = 0
		elif elec == "up": rotation_degrees = 180
		elif elec == "right": rotation_degrees = -90
		elif elec == "left": rotation_degrees = 90
