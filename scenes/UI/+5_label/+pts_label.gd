extends Label



func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($".", "scale", Vector2(1,1), 0.25)
	tween.tween_property($".", "scale", Vector2(0.5,0.5), 0.25)
	tween.tween_property($".", "scale", Vector2(0.0,0.0), 0.15)
	await tween.finished
	queue_free()
