extends CharacterBody2D

var dir = Vector2.RIGHT
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0, 100)
	velocity = dir * speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)
