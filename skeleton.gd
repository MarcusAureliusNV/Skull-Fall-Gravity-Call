extends CharacterBody2D

const SPEED = 200.0
const JUMP_F = 300.0 # increased a bit so it feels responsive
const GRAV = 800.0

const PUSH_FORCE := 50 
const MIN_PUSH_FORCE := 30.0

var can_double_jump = false # this defines whether you can jump in the air or not
var grav_dir = "down" # Gravity starts down
@onready var anim: AnimatedSprite2D = %AnimatedSprite2D

func _physics_process(delta):
	# --- 1. gravity ---
	if grav_dir == "down": velocity.y += GRAV * delta
	elif grav_dir == "up": velocity.y -= GRAV * delta
	elif grav_dir == "right": velocity.x += GRAV * delta
	elif grav_dir == "left": velocity.x -= GRAV * delta

	# --- 2. jump (fixed logic) ---
	update_up_direction()
	
	# reset the jump flag when we touch the floor
	if is_on_floor():
		can_double_jump = true
	
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			# normal first jump
			jump()
		elif can_double_jump:
			# second jump in the air
			jump()
			can_double_jump = false # you need to get to the floor to restart it

	# --- 3. movement ---
	var mov = Input.get_axis("left", "right")
	
	if grav_dir == "down":
		if mov: velocity.x = mov * SPEED
		else: velocity.x = move_toward(velocity.x, 0, SPEED)
		
	elif grav_dir == "up":
		# flipped: now right key moves screen right
		if mov: velocity.x = mov * SPEED 
		else: velocity.x = move_toward(velocity.x, 0, SPEED)
		
	elif grav_dir == "left":
		if mov: velocity.y = mov * SPEED
		else: velocity.y = move_toward(velocity.y, 0, SPEED)
		
	elif grav_dir == "right":
		# flipped: now right key moves "forward" (screen up)
		if mov: velocity.y = -mov * SPEED 
		else: velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# --- 4. animation ---
	if mov != 0:
		anim.play("move")
		if grav_dir != "up":
			if mov < 0: anim.flip_h = false
			else: anim.flip_h = true # If gravity's up, the controls are reversed, so it doesn't go backwards
		else:
			if mov < 0: anim.flip_h = true
			else: anim.flip_h = false
	else:
		anim.play("idle") 

	move_and_slide() # All the pushing stuff must be below this
	
	# --- 5. pushing ---
	for i in get_slide_collision_count(): # Gets everything that it's colliding
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D: # If it's a tomb
			var push_force = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE # Pushes depending on velocity
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force) # Applies the pushing force

# Character rotation and jump direction, in radians
func update_up_direction():
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

func grav_to(n_dir): # Called from game.tscn to update the gravity when its timer is off
	grav_dir = n_dir
	
func jump():
	# just applies the force based on gravity direction
	if grav_dir == "down": velocity.y = -JUMP_F
	elif grav_dir == "up": velocity.y = JUMP_F
	elif grav_dir == "right": velocity.x = -JUMP_F
	elif grav_dir == "left": velocity.x = JUMP_F
