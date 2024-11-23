extends Control



func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($VBoxContainer, 'scale', Vector2(1, 1), 0.35)
