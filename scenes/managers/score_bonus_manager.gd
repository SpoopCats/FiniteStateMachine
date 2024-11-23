extends Node

@export var score_bonus_scene: PackedScene
# reference to the main node
@onready var game: Node2D = $".."
# timer for rolling if a new bonus will spawn
@onready var bonus_timer: Timer = $BonusTimer
# threshold that roll must equal or beat e.g., 85 = roll an 8 or higher
@export var spawn_roll_challenge: int = 85
# reference to in-game timer
@onready var game_timer: Timer = $"../GameTimer/MarginContainer/Timer"

# tells the spawner if it should be running
var spawner_on: bool = true

# possible lanes to spawn in, currently the same as enemy spawn points
# this should maybe be a resource since enemy_manager uses it too
var spawn_points = [
	Vector2(-16, 52),
	Vector2(-16, 84),
	Vector2(-16, 116),
	Vector2(-16, 148),
	Vector2(-16, 180),
	Vector2(-16, 212),
	Vector2(-16, 244),
	Vector2(-16, 276),
	Vector2(-16, 308),
	Vector2(656, 52),
	Vector2(656, 84),
	Vector2(656, 116),
	Vector2(656, 148),
	Vector2(656, 180),
	Vector2(656, 212),
	Vector2(656, 244),
	Vector2(656, 276),
	Vector2(656, 308),
]


func _ready() -> void:
	GameEvents.player_hits_enemy_game_over.connect(_on_player_hits_enemy_game_over)
	GameEvents.time_expired_game_over.connect(_on_time_expired_game_over)
	bonus_timer.timeout.connect(roll_for_bonus_spawn)


func _process(delta: float) -> void:
	_increase_bonus_spawn_rate()


func roll_for_bonus_spawn():
	if spawner_on == true:
		# roll D100
		var roll = randi_range(1, 100)
		# no spawn, exit code
		if roll < spawn_roll_challenge:
			return
		# roll succeeds, spawn in score_bonus.tscn
		if roll >= spawn_roll_challenge: #modify here for changing spawn chances
			var bonus = score_bonus_scene.instantiate()
			var bonus_lane = spawn_points.pick_random()
			bonus.position = bonus_lane
			# check if it should be moving left instead of right
			if bonus.position.x > 640:
				bonus.dir = Vector2.LEFT
			game.add_child(bonus)

# increases the spawn rate of bonuses as game time progresses
func _increase_bonus_spawn_rate():
	if game_timer.time_left < 60:
		spawn_roll_challenge = 65
	if game_timer.time_left < 30:
		spawn_roll_challenge = 45
		

func _on_player_hits_enemy_game_over():
	spawner_on = false


func _on_time_expired_game_over():
	spawner_on = false
