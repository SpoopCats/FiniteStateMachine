extends CharacterBody2D

var dir = Vector2.RIGHT
var speed = 100
@export var lane_to_reopen: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0, 100)
	velocity = dir * speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_is_enemy_on_screen()


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func _is_enemy_on_screen():
	# 656 is the x position where a 32x32 sprite will be fully off screen on the right
	# -16 is the x position ... off screen on the left
	if position.x > 656 or position.x < -16:
		GameEvents.emit_off_screen(lane_to_reopen)
		queue_free()
		
