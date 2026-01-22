extends CharacterBody2D

# Movement constants
const SPEED = 120.0
const JUMP_F = 220.0
const GRAV = 600.0

# initial gravity
var grav_dir = "down" 

# Changes the animated sprite name so it's shorter and waits until the game loaded to use it
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
		velocity.x -= GRAV * delta	# Depending on the array parameter value, it changes the velocity vector so the gravity swaps

	# --- JUMP ---
	if Input.is_action_just_pressed("up") and is_on_floor():	# Makes it so it can only jump when grounded and pressing the assigned key
		# Saltamos hacia el lado contrario de la gravedad
		if grav_dir == "down":
			velocity.y = -JUMP_F
		elif grav_dir == "up":
			velocity.y = JUMP_F
		elif grav_dir == "right":
			velocity.x = -JUMP_F
		elif grav_dir == "left":
			velocity.x = JUMP_F	# "UP" changes depending on the gravity

	# --- MOVEMENT ---
	var mov = Input.get_axis("left", "right")	# Basic movement input
	
	if grav_dir == "down":
		if mov:
			velocity.x = mov * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	elif grav_dir == "up":
		if mov:
			velocity.x = -mov * SPEED
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
	# Upper lines changes the behaviour of the keys depending on the gravity. Right one is inverted so it feels better playing.
	
	# --- ANIMATIONS ---
	if velocity.x != 0 && is_on_floor():
		anim.play("move")	# Looped until it doesn't move
		if mov > 0: anim.flip_h = true
		elif mov < 0: anim.flip_h = false	# Flipping the character sprite depending on direction
	else:
		anim.play("idle") 

	rotate_sprite()	# Calls function, explained lower

	move_and_slide()

func rotate_sprite():	# Uses degrees to rotate the sprite depending on the gravity
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
