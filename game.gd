extends Node2D

var grav_list = ["down", "up", "left", "right"]

var prev  = ""
func _on_timer_timeout() -> void:
	var elec = grav_list.pick_random()
	while prev  == elec:
		elec = grav_list.pick_random()
	if elec != prev :
		prev  = elec
	
	print("Gravity: " + elec)
	
	$Skeleton.grav_to(elec)
	
	var phys_vector = Vector2.DOWN
	
	if elec == "down": phys_vector = Vector2.DOWN
	elif elec == "up": phys_vector = Vector2.UP
	elif elec == "right": phys_vector = Vector2.RIGHT
	elif elec == "left": phys_vector = Vector2.LEFT
	
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, phys_vector)
