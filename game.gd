extends Node2D

# Array used to randomly generate the next gravity change
var grav_list = ["down", "up", "left", "right"] 
var next_grav	# Next gravity variable
var elec	# Current gravity

var prev  = "down"
var score = 0 # Current frozen tombs
var total_tombs = 8	# Total tombs in the level

func _ready():
	%main_menu.visible = true	
	get_tree().paused = true
	next_grav = grav_list.pick_random()
	%UI_Gravity.text = "Next Gravity: \n          " + str(next_grav)	# Initializes the first prediction, if not, the first one doesn't appear
	ui_update()
	
	
func _on_timer_timeout() -> void: 
	while prev  == next_grav:	# So it doesn't repeat the same gravity
		next_grav = grav_list.pick_random()	
	elec = next_grav	# next_grav is the new gravity
	prev = elec
	next_grav = grav_list.pick_random() # It reveals which gravity comes next to its label
	%UI_Gravity.text = "Next Gravity: \n          " + str(next_grav)
	print("Gravity: " + elec) # Console debug
	
	# 1. Rotate Skeleton
	$Skeleton.grav_to(elec) 
	
	# 2. Rotate ALL Tombs (We use a Group so we don't have to list them one by one)
	get_tree().call_group("Tombs", "grav_to", elec)
	
	# 3. To know where the direction is going, so the player moves
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
	ui_update()
	if score >= total_tombs: # Functional door! 
		print("Pillar Cleared!")
		$Pillar/Visibility.visible = true
		$Pillar.set_collision_layer_value(8, true) # So tombs can't pass through the door
		$Pillar.set_collision_layer_value(1, false) # Yet the character can
# Function to update all UI in the screen, and also open the door
func ui_update():
	var how_many_tombs = total_tombs - score
	if how_many_tombs > 0:
		%UI_tombs/Label.text = "Current Tombs Frozen: " + str(score) + " out of " + str(total_tombs) + ". " + str(how_many_tombs) + " left to go!"
	else:
		%UI_tombs/Label.text = "You're free! Run for the door!"
