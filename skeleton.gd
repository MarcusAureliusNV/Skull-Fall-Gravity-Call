extends CharacterBody2D

const VELOCIDAD = 120.0
const SALTO_FUERZA = 220.0
const GRAVEDAD_FUERZA = 700.0

# gravedad inicial
var direccion_gravedad = "abajo" 

@onready var anim: AnimatedSprite2D = %AnimatedSprite2D

func _physics_process(delta):
	
	# --- GRAVEDAD SEGÚN DIRECCIÓN ---
	if direccion_gravedad == "abajo":
		velocity.y += GRAVEDAD_FUERZA * delta
	elif direccion_gravedad == "arriba":
		velocity.y -= GRAVEDAD_FUERZA * delta
	elif direccion_gravedad == "derecha":
		velocity.x += GRAVEDAD_FUERZA * delta
	elif direccion_gravedad == "izquierda":
		velocity.x -= GRAVEDAD_FUERZA * delta

	# --- SALTAR ---
	if Input.is_action_just_pressed("up") and is_on_floor():
		# Saltamos hacia el lado contrario de la gravedad
		if direccion_gravedad == "abajo":
			velocity.y = -SALTO_FUERZA
		elif direccion_gravedad == "arriba":
			velocity.y = SALTO_FUERZA
		elif direccion_gravedad == "derecha":
			velocity.x = -SALTO_FUERZA
		elif direccion_gravedad == "izquierda":
			velocity.x = SALTO_FUERZA

	# --- MOVIMIENTO ---
	var mov = Input.get_axis("left", "right")
	
	if direccion_gravedad == "abajo" or direccion_gravedad == "arriba":
		if mov:
			velocity.x = mov * VELOCIDAD
		else:
			velocity.x = move_toward(velocity.x, 0, VELOCIDAD)
			
	elif direccion_gravedad == "izquierda":
		if mov:
			velocity.y = mov * VELOCIDAD
		else:
			velocity.y = move_toward(velocity.y, 0, VELOCIDAD)
	
	elif direccion_gravedad == "derecha":
		if mov:
			velocity.y = -mov * VELOCIDAD
		else:
			velocity.y = move_toward(velocity.y, 0, VELOCIDAD)
	
	
	# --- ANIMACIONES ---
	if velocity.length() > 20:
		anim.play("move")
		if direccion_gravedad == "arriba":
			if mov > 0: anim.flip_h = false
			elif mov < 0: anim.flip_h = true
		else:
			if mov > 0: anim.flip_h = true
			elif mov < 0: anim.flip_h = false
	else:
		anim.stop() # no tengo todavía ninguna animación idle

	actualizar_rotacion()

	move_and_slide()

func actualizar_rotacion():
	if direccion_gravedad == "abajo":
		rotation_degrees = 0
		up_direction = Vector2.UP 
	elif direccion_gravedad == "arriba":
		rotation_degrees = 180
		up_direction = Vector2.DOWN
	elif direccion_gravedad == "derecha":
		rotation_degrees = -90
		up_direction = Vector2.LEFT
	elif direccion_gravedad == "izquierda":
		rotation_degrees = 90
		up_direction = Vector2.RIGHT


func cambiar_gravedad_a(nueva_direccion):
	direccion_gravedad = nueva_direccion
