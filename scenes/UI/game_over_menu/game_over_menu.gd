extends Control

# neighbours not set for buttons yet
# see this tutorial to setup: https://youtu.be/Mx3iyz8AUAE?si=6mYd4O2LqKQbzZlQ&t=165


func _ready() -> void:
	$MarginContainer/VBoxContainer/PlayAgain.grab_focus()


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
