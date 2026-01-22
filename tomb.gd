extends RigidBody2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node) -> void:
	# If the object we touched has "Remains" in its name, start the timer
	if "Remains" in body.name:
		timer.start()

func _on_timer_timeout() -> void:
	# Stop the tombstone right where it is
	freeze = true
	print("Buenas")
