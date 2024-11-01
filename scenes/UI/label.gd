extends Label


var score = 0


func _ready() -> void:
	GameEvents.increase_score.connect(_on_score_increase)


func _on_score_increase(score_amt: int):
	score += score_amt
	text = str(score)
