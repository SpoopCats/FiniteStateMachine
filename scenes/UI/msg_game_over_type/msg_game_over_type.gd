extends Control

@onready var game_over_type: Label = $MarginContainer/GameOverType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	if GameOverManager.game_over_by_player_hitting_enemy == true:
		game_over_type.text = "Cats win! Meow!"
	if GameOverManager.game_over_by_time == true:
		game_over_type.text = "Time Expired!
		Ralph got away!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
