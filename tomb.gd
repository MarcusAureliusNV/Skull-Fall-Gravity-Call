extends RigidBody2D

@onready var timer: Timer = $TombTimer
var target_rotation: float = 0.0 # Store the desired angle here

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Remains"):
		if timer.is_stopped() and not freeze:
			timer.start()

func _on_timer_timeout() -> void:
	freeze = true
	var game = get_tree().root.get_node("Game")
	if game.has_method("add_point"):
		game.add_point()

# This is the "Setter" called by game.gd
func grav_to(elec):
	if freeze:
		return	# It doesn't do anything if it's already frozen 
	else:	# Rotates the tombs so it can kill the player
		if elec == "down": target_rotation = 0
		elif elec == "up": target_rotation = 180
		elif elec == "right": target_rotation = -90
		elif elec == "left": target_rotation = 90
	


# This is the magic physics function
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not freeze:
		# We create a new "Transform" with the rotation we want
		var t = state.transform
		var new_rotation = deg_to_rad(target_rotation)
		
		# Apply the rotation to the physics state directly
		state.transform = Transform2D(new_rotation, t.origin)



@onready var death_ui: Control = %Death_ui

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Skeleton" and body.is_on_floor():
		death_ui.visible = true
		get_tree().paused = true
