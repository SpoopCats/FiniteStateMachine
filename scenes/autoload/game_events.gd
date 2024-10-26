extends Node


#Signal for telling game it's time to increment the score
signal increase_score()


# Emits the custom signal for incrementing the score
func emit_increase_score():
	increase_score.emit()
