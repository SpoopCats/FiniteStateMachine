extends Timer



func _on_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/game_over_menu/game_over_menu.tscn")
