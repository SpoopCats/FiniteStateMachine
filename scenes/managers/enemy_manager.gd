extends Node

# could this be an array of packed scenes that can be chosen from?
# with all cat parameters set?
# is that easier?
# then we can just handle the logic of instantiating X enemy type 
# that is already chosen?
# here is documentation on it
# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html#exporting-arrays

# I could randomize textures with different behaviours possibly...
# this could be confusing to the player though if they look different but
# act the same as others.
# perhaps variations could exist like color?
# can also be done with textures
#@export var enemy_textures: Array[Texture] = []

# signal that enemy will emit when it has reached a position threshold
# to tell the enemy_manager that it is off screen + lane should be open again

# this could be turned into multiple packed scenes in an array
@export var enemy_scene: PackedScene
# timer that on timeout starting spawning sequence of new enemy
@onready var spawn_timer: Timer = $SpawnTimer
# reference to the Main node game scene
@onready var game: Node2D = $".."


#possible spawn lanes, just two on the right currently.
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
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)


func _process(delta: float) -> void:
	pass


func _on_off_screen(lane_to_open):
	#here is where you could reopen lanes if you were closing them
	pass


func _pick_and_close_lane(spawns: Array):
	var picked_lane = spawns.pick_random()
	#close lane here too if you want to close lanes
	return picked_lane


# here is where all the code for enemy instantiation happens
func _on_spawn_timer_timeout():
	# set the timer to a new value to vary enemy spawn rate
	randomize_timer()
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
func randomize_timer():
	var timer_value = randf_range(0.75,1.5)
	spawn_timer.wait_time = timer_value
