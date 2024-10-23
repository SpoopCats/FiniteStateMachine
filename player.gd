extends CharacterBody2D

@export var move_speed: int

func _physics_process(delta: float) -> void:
	move_and_slide()
