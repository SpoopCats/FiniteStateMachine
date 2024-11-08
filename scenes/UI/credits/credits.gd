extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ButtonContainer/VBoxContainer/Back.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/UI/start_menu/start_menu.tscn')
