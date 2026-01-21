extends Node2D

var lista_gravedades = ["abajo", "arriba", "izquierda", "derecha"]

var previo = ""
func _on_timer_timeout() -> void:
	var eleccion = lista_gravedades.pick_random()
	while previo == eleccion:
		eleccion = lista_gravedades.pick_random()
	if eleccion != previo:
		previo = eleccion
	
	print("Cambiando gravedad a: " + eleccion)
	
	$Skeleton.cambiar_gravedad_a(eleccion)
	
	var vector_fisicas = Vector2.DOWN
	
	if eleccion == "abajo": vector_fisicas = Vector2.DOWN
	elif eleccion == "arriba": vector_fisicas = Vector2.UP
	elif eleccion == "derecha": vector_fisicas = Vector2.RIGHT
	elif eleccion == "izquierda": vector_fisicas = Vector2.LEFT
	
	PhysicsServer2D.area_set_param(get_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, vector_fisicas)
