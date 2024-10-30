extends Label


var score = 0


func _ready() -> void:
	GameEvents.increase_score.connect(_on_score_increase)


func _on_score_increase():
	score += 1
	text = str(score)
