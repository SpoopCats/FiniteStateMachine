extends Control

@onready var yes_button: Button = $MarginContainer/VBoxContainer/ButtonMarginContainer/ButtonHBox/YesButton
@onready var no_button: Button = $MarginContainer/VBoxContainer/ButtonMarginContainer/ButtonHBox/NoButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	no_button.grab_focus()

func _process(delta: float) -> void:
	# this just stops the player from accessing the menu behind this one.
	# I know this isn't the proper way to do this, but it works!
	if Input.is_action_just_pressed('ui_up'):
		no_button.grab_focus()
	if Input.is_action_just_pressed('ui_down'):
		no_button.grab_focus()


func _on_no_button_pressed() -> void:
	GameEvents.emit_grab_focus()
	queue_free()


func _on_yes_button_pressed() -> void:
	ScoreManager.current_score = 0
	ScoreManager.save_score()
	GameEvents.emit_grab_focus()
	queue_free()
