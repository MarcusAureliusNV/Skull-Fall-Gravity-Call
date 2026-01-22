extends Node2D

# Array used to randomly generate the next gravity change
var grav_list = ["down", "up", "left", "right"] 


var prev  = "down"	#Declared outside so it saves every time the timeout signals
func _on_timer_timeout() -> void: # Signal from the Gravity Timer
	var elec = grav_list.pick_random()	# Function to randomly take one element from the array
	while prev  == elec:	# While to make sure it doesn't repeat, making the gravity last double
		elec = grav_list.pick_random()
	if elec != prev :
		prev  = elec	# Changing the value of a variable out of a function saves it for later
	
	print("Gravity: " + elec)	# Debug
	
	$Skeleton.grav_to(elec) # Calling the function so it changes the player's gravity
	
	var phys_vector = Vector2.DOWN
	
	if elec == "down": phys_vector = Vector2.DOWN
	elif elec == "up": phys_vector = Vector2.UP
	elif elec == "right": phys_vector = Vector2.RIGHT
	elif elec == "left": phys_vector = Vector2.LEFT	# Declared as a vector and then comparing to the array value
	
	# Basically changes the global gravity from the game so it doesn't have to be applied to every other moving scene in the game
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, phys_vector)
