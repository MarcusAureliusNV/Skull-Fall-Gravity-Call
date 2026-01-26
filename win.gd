extends Control

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()	# Reloads the game

func _on_quit_pressed() -> void:
	get_tree().quit()
