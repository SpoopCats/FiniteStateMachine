extends Node


@export var food_scene: PackedScene
# references the Main node
@onready var game: Node2D = $".."

var top_food_pos = Vector2(320, 8)
var btm_food_pos = Vector2(320, 352)


func _ready() -> void:
	GameEvents.spawn_food_top.connect(_on_spawn_food_top)
	GameEvents.spawn_food_btm.connect(_on_spawn_foot_btm)


func _on_spawn_food_top():
	var food_to_spawn = food_scene.instantiate()
	food_to_spawn.position = top_food_pos
	# must use call deferred here or the food won't spawn right as game loads
	game.add_child.call_deferred(food_to_spawn)
	
	print("spawning food on top!")


func _on_spawn_foot_btm():
	var food_to_spawn = food_scene.instantiate()
	food_to_spawn.position = btm_food_pos
	# don't have to use call_deffered here, just did it to see if it still works
	game.add_child.call_deferred(food_to_spawn)
	print("spawning food on btm!")
