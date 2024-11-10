extends Control

# neighbours not set for buttons yet
# see this tutorial to setup: https://youtu.be/Mx3iyz8AUAE?si=6mYd4O2LqKQbzZlQ&t=165
@export var new_high_score_scene : PackedScene
@onready var new_high_score_label: Control = $NewHighScore

func _ready() -> void:
	$ButtonContainer/VBoxContainer/MarginContainer3/PlayAgain.grab_focus()
	if ScoreManager.current_score == ScoreManager.high_score:
		# do something to notify player of new high score
		new_high_score_label.show()


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
