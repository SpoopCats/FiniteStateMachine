extends Node2D


@onready var sprite_2d: Sprite2D = $Sprite2D


@export var food_textures: Array[Texture] = []


func _ready() -> void:
	sprite_2d.texture = food_textures.pick_random()


func _process(delta: float) -> void:
	pass
