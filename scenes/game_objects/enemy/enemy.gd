extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var cat_texture: Array[Texture] = []

@export var dir = Vector2.RIGHT
@export var speed = 100
@export var lane_to_reopen: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = cat_texture.pick_random()
	velocity = dir * speed
	# flip the entire node to face the other way by altering it's scale
	if velocity.x < 0:
		scale = Vector2(-1, 1)


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
		
