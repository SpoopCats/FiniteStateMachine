extends Node

# bools that let the game know how the game ended
# either by time expiring or by player hitting enemy
var game_over_by_time: bool = false
var game_over_by_player_hitting_enemy: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.time_expired_game_over.connect(_on_time_expired_game_over)
	GameEvents.player_hits_enemy_game_over.connect(_on_player_hits_enemy_game_over)


func _on_time_expired_game_over():
	game_over_by_time = true


func _on_player_hits_enemy_game_over():
	game_over_by_player_hitting_enemy = true
