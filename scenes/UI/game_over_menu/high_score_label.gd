extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# make sure ScoreManager.high_score is up to date
	ScoreManager.load_score()
	text = 'High Score: ' + str(ScoreManager.high_score)
