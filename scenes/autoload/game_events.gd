extends Node


#Signal for telling game it's time to increment the score
signal increase_score()

signal off_screen()

# Emits the custom signal for incrementing the score
func emit_increase_score():
	increase_score.emit()


func emit_off_screen(lane):
	off_screen.emit(lane)
