extends Control

# neighbours not set for buttons yet
# probably only need it on Play UP & Quit DOWN so it loops
# see this tutorial to setup: https://youtu.be/Mx3iyz8AUAE?si=6mYd4O2LqKQbzZlQ&t=165

func _ready() -> void:
	$ButtonContainer/VBoxContainer/MarginContainer/Play.grab_focus()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/settings_menu/settings_menu.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/credits/credits.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
