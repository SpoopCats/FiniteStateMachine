extends CharacterBody2D


@onready var sprite_2d: Sprite2D = $Sprite2D


@export var cat_texture: Array[Texture] = []
@export var dir = Vector2.RIGHT
@export var speed = 100
@export var lane_to_reopen: Vector2


func _ready() -> void:
	GameEvents.player_hits_enemy_game_over.connect(_on_player_hits_enemy_game_over)
	sprite_2d.texture = cat_texture.pick_random()
	velocity = dir * speed
	# if travelling to the left
	if velocity.x < 0:
		# flip the entire node to face the other way by altering it's scale
		scale = Vector2(-1, 1)


func _process(delta: float) -> void:
	_is_enemy_on_screen()


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


# for releasing enemies from memory when off screen
func _is_enemy_on_screen():
	# 656 is the x position where a 32x32 sprite will be fully off screen on the right
	# -16 is the x position ... off screen on the left
	if position.x > 656 or position.x < -16:
		GameEvents.emit_off_screen(lane_to_reopen)
		queue_free()


func _on_player_hits_enemy_game_over():
	print("Enemy knows game is over.")
	queue_free()
