extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = 'Score: ' + str(ScoreTracker.current_score)
