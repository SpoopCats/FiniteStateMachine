extends Node


@export var food_scene: PackedScene
# references the Main node
@onready var game: Node2D = $".."


func _ready() -> void:
	GameEvents.spawn_food_top.connect(_on_spawn_food_top)
	GameEvents.spawn_food_btm.connect(_on_spawn_foot_btm)


func _on_spawn_food_top():
	print("spawning food on top!")


func _on_spawn_foot_btm():
	print("spawning food on btm!")
