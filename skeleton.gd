extends CharacterBody2D

const SPEED = 120.0
const JUMP_F = 220.0
const GRAV = 600.0
const PUSH_FORCE = 50.0

var grav_dir = "down" 
@onready var anim: AnimatedSprite2D = %AnimatedSprite2D

func _physics_process(delta):
	if grav_dir == "down": velocity.y += GRAV * delta
	elif grav_dir == "up": velocity.y -= GRAV * delta
	elif grav_dir == "right": velocity.x += GRAV * delta
	elif grav_dir == "left": velocity.x -= GRAV * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		if grav_dir == "down": velocity.y = -JUMP_F
		elif grav_dir == "up": velocity.y = JUMP_F
		elif grav_dir == "right": velocity.x = -JUMP_F
		elif grav_dir == "left": velocity.x = JUMP_F

	# --- MOVEMENT (Your existing code) ---
	var mov = Input.get_axis("left", "right")
	
	# Store the move direction for pushing later
	var push_vector = Vector2.ZERO
	
	if grav_dir == "down":
		if mov: 
			velocity.x = mov * SPEED
			push_vector = Vector2(mov, 0) # Pushing Left or Right
		else: velocity.x = move_toward(velocity.x, 0, SPEED)
	elif grav_dir == "up":
		if mov: 
			velocity.x = -mov * SPEED
			push_vector = Vector2(-mov, 0)
		else: velocity.x = move_toward(velocity.x, 0, SPEED)
	elif grav_dir == "left":
		if mov: 
			velocity.y = mov * SPEED
			push_vector = Vector2(0, mov) # Pushing Up or Down relative to screen
		else: velocity.y = move_toward(velocity.y, 0, SPEED)
	elif grav_dir == "right":
		if mov: 
			velocity.y = -mov * SPEED
			push_vector = Vector2(0, -mov)
		else: velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# --- ANIMATION ---
	if velocity.length() > 10 and is_on_floor():
		anim.play("move")
		if mov > 0: anim.flip_h = true
		elif mov < 0: anim.flip_h = false
	else:
		anim.play("idle") 

	rotate_sprite()
	move_and_slide()
	
	# --- PUSHING LOGIC ---
	# We check if we hit something AFTER moving
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body is RigidBody2D and mov != 0:
			body.apply_central_impulse(push_vector * PUSH_FORCE)

func rotate_sprite():
	if grav_dir == "down": rotation_degrees = 0; up_direction = Vector2.UP 
	elif grav_dir == "up": rotation_degrees = 180; up_direction = Vector2.DOWN
	elif grav_dir == "right": rotation_degrees = -90; up_direction = Vector2.LEFT
	elif grav_dir == "left": rotation_degrees = 90; up_direction = Vector2.RIGHT

func grav_to(n_dir):
	grav_dir = n_dir
