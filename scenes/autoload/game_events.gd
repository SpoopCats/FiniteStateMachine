extends Node


# Signal for telling game it's time to increment the score
signal increase_score()
# Signal for telling game that enemy is off the screen
signal off_screen()
# Signals for spawning food on the pedestal Ralph is not on
signal spawn_food_top
signal spawn_food_btm
# Signal for game over when time runs out
signal time_expired_game_over
# Signal for game over when player hits an enemy
# Linked to the game over animation across many scenes
	# player root node CharacterBody2D
		# player FSM moving_up.gd and moving_down.gd
	# enemy_manager.gd
	# score_bonus_manager.gd
	# enemy.gd = all the enemies on screen
	# score_bonus.gd = all the peanut butter on screen
signal player_hits_enemy_game_over

# Emits the custom signal for incrementing the score
func emit_increase_score(score_amt: int):
	increase_score.emit(score_amt)


func emit_off_screen(lane):
	off_screen.emit(lane)


func emit_spawn_food_top():
	spawn_food_top.emit()


func emit_spawn_food_btm():
	spawn_food_btm.emit()


func emit_time_expired_game_over():
	time_expired_game_over.emit()


func emit_player_hits_enemy_game_over():
	player_hits_enemy_game_over.emit()
