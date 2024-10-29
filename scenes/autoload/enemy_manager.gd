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
# reference to the main game scene
@onready var game: Node2D = $".."


#possible spawn lanes, just two on the right currently.
var spawn_points = [Vector2(-16, 84), Vector2(-16, 244), Vector2(-16, 180), Vector2(-16, 148)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.off_screen.connect(_on_off_screen)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_off_screen(lane_to_open):
	print("_on_off_screen detected by enemy manager: open lane " + str(lane_to_open))
	pass


func _pick_and_close_lane(spawns: Array):
	var picked_lane = spawns.pick_random()
	#close lane here too
	return picked_lane


# here is where all the code for enemy instantiation happens
func _on_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	game.add_child(enemy)
	var enemy_lane = _pick_and_close_lane(spawn_points)
	enemy.position = enemy_lane
	
