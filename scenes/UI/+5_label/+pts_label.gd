extends Label

@onready var score_bonus: AudioStreamPlayer2D = $ScoreBonus


func _ready() -> void:
	var tween = create_tween()
	score_bonus.play()
	tween.set_parallel(true)
	tween.tween_property($".", "scale", Vector2(1,1), 0.35)
	tween.tween_property($".", "position", position + Vector2(0,-25), 0.35)
	tween.set_parallel(false)
	tween.tween_property($".", "scale", Vector2(0.5,0.5), 0.25)
	tween.tween_property($".", "scale", Vector2(0.0,0.0), 0.15)
	await tween.finished
	queue_free()
