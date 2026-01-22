extends Area2D

@onready var timer: Timer = $Timer


func _on_area_entered(area: Area2D) -> void:
	if is_in_group("Tombs"): 
		timer.start()
		
