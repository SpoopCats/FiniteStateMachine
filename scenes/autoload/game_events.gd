extends Node


# Signal for telling game it's time to increment the score
signal increase_score()
# Signal for telling game that enemy is off the screen
signal off_screen()
# Signals for spawning food on the pedestal Ralph is not on
signal spawn_food_top
signal spawn_food_btm

# Emits the custom signal for incrementing the score
func emit_increase_score():
	increase_score.emit()


func emit_off_screen(lane):
	off_screen.emit(lane)


func emit_spawn_food_top():
	spawn_food_top.emit()


func emit_spawn_food_btm():
	spawn_food_btm.emit()
