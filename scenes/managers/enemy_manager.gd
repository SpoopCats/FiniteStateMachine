extends Node


# this could be turned into multiple packed scenes in an array
@export var enemy_scene: PackedScene
# timer that on timeout starting spawning sequence of new enemy
@onready var spawn_timer: Timer = $SpawnTimer
# reference to the Main node game scene
@onready var game: Node2D = $".."
#reference to the in-game timer, different than the spawn timer!
@onready var game_timer: Timer = $"../GameTimer/MarginContainer/Timer"


# says if the spawner should be working
var spawner_on: bool = true
# range for spawn timer to increase difficulty as the game goes on
var lower_bound_sec: float = 0.75
var upper_bound_sec: float = 1.5


# possible spawn lanes, just two on the right currently.
# this should maybe be a resource since score_bonus_manager uses it too
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
	GameEvents.off_screen.connect(_on_off_screen)
	# connect to signal to turn off the spawner for game over animations
	GameEvents.player_hits_enemy_game_over.connect(_on_player_hits_enemy_game_over)
	GameEvents.time_expired_game_over.connect(_on_time_expired_game_over)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)


func _process(delta: float) -> void:
	_increase_difficulty()


func _on_off_screen(lane_to_open):
	#here is where you could reopen lanes if you were closing them
	pass


func _pick_and_close_lane(spawns: Array):
	var picked_lane = spawns.pick_random()
	#close lane here too if you want to close lanes
	return picked_lane


# here is where all the code for enemy instantiation happens
func _on_spawn_timer_timeout():
	if spawner_on == true:
		# set the timer to a new value to vary enemy spawn rate
		randomize_timer(lower_bound_sec, upper_bound_sec)
		var enemy = enemy_scene.instantiate()
		# is closing the lane necessary right now? maybe if powerups get added to the game?
		var enemy_lane = _pick_and_close_lane(spawn_points)
		enemy.position = enemy_lane
		# randomize enemy speed a bit
		enemy.speed = randi_range(80,120)
		# make enemies spawning on right side of screen go left
		if enemy.position.x > 640:
			enemy.dir = Vector2.LEFT
		game.add_child(enemy)
	
# randomize spawn timer a bit so it's not just 1 second
func randomize_timer(lower: float, upper: float):
	var timer_value = randf_range(lower ,upper)
	spawn_timer.wait_time = timer_value
	
# increase difficulty based upon amount of time left on in-game timer
# the spawn_rate rolls upper and lower bound are editted to make spawns more
# likely
func _increase_difficulty():
	if game_timer.time_left < 60:
		upper_bound_sec = 1.15
		lower_bound_sec = 0.5
	if game_timer.time_left < 30:
		upper_bound_sec = 1
		lower_bound_sec = 0.35


func _on_player_hits_enemy_game_over():
	spawner_on = false


func _on_time_expired_game_over():
	spawner_on = false
