extends Control

@onready var main_menu: Control = $"."


func _on_play_demo_pressed() -> void:
	get_tree().paused = false	# Game is paused from the start
	main_menu.visible = false	# So when this button is pressed everything starts working
	%UI_tombs.visible = true	# Both UIs appear so it doesn't appear in the menu
	%UI_Gravity.visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()	# Quit the game
