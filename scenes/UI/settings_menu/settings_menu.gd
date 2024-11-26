extends Control

@export var confirm_del_scene: PackedScene
@onready var back_button: Button = $SettingsContainer/VBoxContainer/MarginContainer2/BackButton


func _ready() -> void:
	GameEvents.grab_focus.connect(_on_grab_focus)
	back_button.grab_focus()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)


func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_mute_music_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		BkgroundMusic.stream_paused = true
	if toggled_on == false:
		BkgroundMusic.stream_paused = false


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/start_menu/start_menu.tscn")


func _on_del_high_score_button_pressed() -> void:
	var confirm_del_scene_instance = confirm_del_scene.instantiate()
	add_child(confirm_del_scene_instance)


func _on_grab_focus():
	back_button.grab_focus()
