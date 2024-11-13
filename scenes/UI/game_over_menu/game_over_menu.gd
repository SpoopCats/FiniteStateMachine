extends Control

# neighbours not set for buttons yet
# see this tutorial to setup: https://youtu.be/Mx3iyz8AUAE?si=6mYd4O2LqKQbzZlQ&t=165
@export var new_high_score_scene : PackedScene
@onready var new_high_score_label: Control = $NewHighScore
@onready var msg_game_over_type: Control = $MsgGameOverType

func _ready() -> void:
	
	###
	# since things aren't displaying 100% correctly here,
	# could it be that I need elif statments?
	# also first time through not sure if high score recording is working
	# right after the save file has been deleted?
	# when time expires high score doesn't update which will be in the 
	# timer scene because it's saved in the player scene...
	###
	
	$ButtonContainer/VBoxContainer/MarginContainer3/PlayAgain.grab_focus()
	if ScoreManager.current_score == ScoreManager.high_score:
		# do something to notify player of new high score
		new_high_score_label.show()
	if GameOverManager.game_over_by_time == true:
		# do something to notify player that game ended due to time expiring
		msg_game_over_type.show()
		print("Game ended by time!")
	if GameOverManager.game_over_by_player_hitting_enemy == true:
		msg_game_over_type.show()
		# do things to display that game ended by time
		print("Game ended by hitting enemy!")

func _on_play_again_pressed() -> void:
	# reset game over tracking to both game over scenarios to false
	GameOverManager.game_over_by_player_hitting_enemy = false
	GameOverManager.game_over_by_time = false
	GameOverManager.tutorial_needed = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
