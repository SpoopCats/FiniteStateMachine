extends Node

@export var score_bonus_scene: PackedScene
# reference to the main node
@onready var game: Node2D = $".."
@onready var bonus_timer: Timer = $BonusTimer
@export var spawn_chance: int = 50 #50% currently

# possible lanes to spawn in, currently the same as enemy spawn points
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
	bonus_timer.timeout.connect(roll_for_bonus_spawn)


func roll_for_bonus_spawn():
	var roll = randi_range(0, 100)
	# no spawn, exit code
	if roll < spawn_chance:
		return
	# roll succeeds, spawn in score_bonus.tscn
	if roll >= spawn_chance: #modify here for changing spawn chances
		var bonus = score_bonus_scene.instantiate()
		var bonus_lane = spawn_points.pick_random()
		bonus.position = bonus_lane
		# check if it should be moving left instead of right
		if bonus.position.x > 640:
			bonus.dir = Vector2.LEFT
		game.add_child(bonus)
