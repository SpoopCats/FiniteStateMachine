extends CharacterBody2D

@export var score_for_eating = 1

func _ready() -> void:
	GameEvents.player_hits_enemy_game_over.connect(_on_player_hits_enemy_game_over)
	

func _on_player_hits_enemy_game_over():
	print('rat picture knows game is over')
