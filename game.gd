extends Node2D

# Array used to randomly generate the next gravity change
var grav_list = ["down", "up", "left", "right"] 

var prev  = "down"
var score = 5 # Current frozen tombs
var total_tombs = 6

func _on_timer_timeout() -> void: 
	var elec = grav_list.pick_random()
	while prev  == elec:
		elec = grav_list.pick_random()
	if elec != prev :
		prev  = elec
	
	print("Gravity: " + elec)
	
	# 1. Rotate Skeleton
	$Skeleton.grav_to(elec) 
	
	# 2. Rotate ALL Tombs (We use a Group so we don't have to list them one by one)
	get_tree().call_group("Tombs", "grav_to", elec)
	
	# 3. Physics update
	var phys_vector = Vector2.DOWN
	
	if elec == "down": phys_vector = Vector2.DOWN
	elif elec == "up": phys_vector = Vector2.UP
	elif elec == "right": phys_vector = Vector2.RIGHT
	elif elec == "left": phys_vector = Vector2.LEFT 
	
	# Ugly line of code that changes the world's config gravity, so it changes for everything in the game at once
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, phys_vector)

# This function is called by the tombs when they freeze
func add_point():
	score += 1
	print("Score: ", score)
	
	if score >= total_tombs: # Functional door! 
		print("Pillar Cleared!")
		$Pillar/Visibility.visible = true
		$Pillar.set_collision_layer_value(8, true) # So tombs can't pass through the door
		$Pillar.set_collision_layer_value(1, false) # Yet the character can
