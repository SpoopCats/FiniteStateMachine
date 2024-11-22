extends Node2D

@onready var food: Node2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var food_textures: Array[Texture] = []


# spot where the food spawns in
# this is hardcoded and taken from the garbage can and garbage bag pos
var top_spawn_pos = Vector2(274, 28)
var btm_spawn_pos = Vector2(356, 319)

# final position for tweens to end on, corresponds to the pedestals in the
# main.tscn scene
# these can likely be hooked up via code but are hard coded here now
var final_top_food_pos = Vector2(320, 8)
var final_btm_food_pos = Vector2(320, 352)


func _ready() -> void:
	GameEvents.player_hits_enemy_game_over.connect(_on_player_hits_enemy_game_over)
	scale = Vector2(0.5, 0.5)
	# move to infront of the background, but behind garbage can / bag
	get_parent().move_child(food, 4)
	sprite_2d.texture = food_textures.pick_random()
	# if behind the garbage CAN at the top of the scene
	# do this tween
	if position == top_spawn_pos:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property($".", 'scale', Vector2(1, 1), 0.35)
		tween.tween_property($".", 'rotation', 6.283185, 0.35)
		tween.tween_property($".", "position", final_top_food_pos, 0.35)
	# if behind the garbage BAG at the btm of the scene
	# do this tween
	if position == btm_spawn_pos:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property($".", 'scale', Vector2(1, 1), 0.35)
		tween.tween_property($".", 'rotation', 6.283185, 0.35)
		tween.tween_property($".", "position", final_btm_food_pos, 0.35)

func _process(delta: float) -> void:
	pass


func _on_player_hits_enemy_game_over():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($".", 'scale', Vector2(0, 0), 0.35)
	tween.tween_property($".", 'rotation', 6.283185, 0.25)
	await  tween.finished
	queue_free()
