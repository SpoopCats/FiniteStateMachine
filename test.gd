extends Node2D

@export var label_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene_instance = label_scene.instantiate()
	scene_instance.position = Vector2(100,100)
	add_child(scene_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
