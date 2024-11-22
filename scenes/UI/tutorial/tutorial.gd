extends Control

@onready var timer: Timer = $Timer


func _ready() -> void:
	hide()
	# only shows tutorial for first round the player plays
	if GameOverManager.tutorial_needed == true:
		show()
	else:
		return


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		timer.start(0)


func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property($VBoxContainer, 'scale', Vector2(0,0), 0.25)
	await tween.finished
	queue_free()
