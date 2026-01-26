extends Control

func _on_try_again_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_sad_face_pressed() -> void:
	get_tree().quit()
