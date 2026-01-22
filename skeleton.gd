extends CharacterBody2D

const SPEED = 120.0
const JUMP_F = 220.0
const GRAV = 700.0

# initial gravity
var grav_dir = "down" 

@onready var anim: AnimatedSprite2D = %AnimatedSprite2D

func _physics_process(delta):
	
	# --- GRAVITY ---
	if grav_dir == "down":
		velocity.y += GRAV * delta
	elif grav_dir == "up":
		velocity.y -= GRAV * delta
	elif grav_dir == "right":
		velocity.x += GRAV * delta
	elif grav_dir == "left":
		velocity.x -= GRAV * delta

	# --- JUMP ---
	if Input.is_action_just_pressed("up") and is_on_floor():
		# Saltamos hacia el lado contrario de la gravedad
		if grav_dir == "down":
			velocity.y = -JUMP_F
		elif grav_dir == "up":
			velocity.y = JUMP_F
		elif grav_dir == "right":
			velocity.x = -JUMP_F
		elif grav_dir == "left":
			velocity.x = JUMP_F

	# --- MOVEMENT ---
	var mov = Input.get_axis("left", "right")
	
	if grav_dir == "down" or grav_dir == "up":
		if mov:
			velocity.x = mov * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	elif grav_dir == "left":
		if mov:
			velocity.y = mov * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	
	elif grav_dir == "right":
		if mov:
			velocity.y = -mov * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	
	
	# --- ANIMATIONS ---
	if velocity.length() > 20:
		anim.play("move")
		if grav_dir == "up":
			if mov > 0: anim.flip_h = false
			elif mov < 0: anim.flip_h = true
		else:
			if mov > 0: anim.flip_h = true
			elif mov < 0: anim.flip_h = false
	else:
		anim.stop() # no idle animation yet

	rotate_sprite()

	move_and_slide()

func rotate_sprite():
	if grav_dir == "down":
		rotation_degrees = 0
		up_direction = Vector2.UP 
	elif grav_dir == "up":
		rotation_degrees = 180
		up_direction = Vector2.DOWN
	elif grav_dir == "right":
		rotation_degrees = -90
		up_direction = Vector2.LEFT
	elif grav_dir == "left":
		rotation_degrees = 90
		up_direction = Vector2.RIGHT

# function to import the new gravity from game.tscn
func grav_to(n_dir):
	grav_dir = n_dir
