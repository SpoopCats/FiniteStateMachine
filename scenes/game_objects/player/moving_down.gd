extends State


class_name MovingDown

@onready var scene_change_timer: Timer = $"../../SceneChangeTimer"
@onready var player: CharacterBody2D = $"../.."
@export var pts_label_scene: PackedScene
@export var game_over_msg_scene: PackedScene
@export var times_over_msg_scene: PackedScene


var dir: Vector2 = Vector2.DOWN
var speed: int = 470
var player_velocity = dir * speed
var collision_info: KinematicCollision2D
# makes sure the game over signal only emits once
var cat_collision_count:= 0


func Enter():
	# connect the game_over signal
	GameEvents.player_hits_enemy_game_over.connect(_on_player_hits_enemy_game_over)
	GameEvents.time_expired_game_over.connect(_on_time_expired_game_over)


func Update(delta: float):
	pass


func Physics_Update(delta: float):
	collision_info = player.move_and_collide(player_velocity * delta)
	if collision_info:
		# store the node collided with using get_collider()
		var node_collided_with = collision_info.get_collider()
		# test it to see if its in certain groups
		if node_collided_with.is_in_group('btm_pedestal'):
			Transitioned.emit(self, "waitbtm")
		if node_collided_with.is_in_group('score_bonus'):
			# instantiate the pts label to tell player they got bonus pts
			var scene_instance = pts_label_scene.instantiate()
			var instance_pos = collision_info.get_position()
			instance_pos.x = instance_pos.x + 8
			scene_instance.position = instance_pos
			get_parent().add_child(scene_instance)
			# increases score by score_bonus' property of score_bonus_amt
			GameEvents.emit_increase_score(node_collided_with.score_bonus_amt)
			node_collided_with.queue_free()
		if node_collided_with.is_in_group('enemy'):
			if cat_collision_count == 0:
				cat_collision_count += 1
				#placeholder code for something that happens when Ralph hits enemies
				GameOver.play()
				# change the boolean value in GameOverManager for how the game ended
				GameEvents.emit_player_hits_enemy_game_over()
				# if score is higher than high score, save the high score
				if ScoreManager.current_score > ScoreManager.high_score:
					ScoreManager.save_score()
				#get_tree().change_scene_to_file('res://scenes/UI/game_over_menu/game_over_menu.tscn')


func _on_player_hits_enemy_game_over():
	player_hit_enemy_game_over_tween()


func _on_time_expired_game_over():
	times_up_game_over_tween()


func player_hit_enemy_game_over_tween():
	# stop player from moving
	player_velocity = Vector2.ZERO
	# tween player object
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(player, 'scale', Vector2(0, 0), 0.35)
	tween.tween_property(player, 'rotation', 6.283185, 0.25)
	await  tween.finished
	player.hide()
	# instantiate game over msg
	var game_over_msg_instance = game_over_msg_scene.instantiate()
	game_over_msg_instance.position = Vector2(640 / 2, 360 / 2)
	# really sloppy way of referencing the main game scene!
	get_parent().get_parent().get_parent().add_child(game_over_msg_instance)
	scene_change_timer.start()


func times_up_game_over_tween():
	# stop player from moving
	player_velocity = Vector2.ZERO
	# tween player object
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(player, 'scale', Vector2(0, 0), 0.35)
	tween.tween_property(player, 'rotation', 6.283185, 0.25)
	await  tween.finished
	player.hide()
	# instantiate game over msg
	var times_up_msg_instance = times_over_msg_scene.instantiate()
	times_up_msg_instance.position = Vector2(640 / 2, 360 / 2)
	# really sloppy way of referencing the main game scene!
	get_parent().get_parent().get_parent().add_child(times_up_msg_instance)
	scene_change_timer.start()


func Exit():
	# disconnects the player hits enemy game over
	GameEvents.player_hits_enemy_game_over.disconnect(_on_player_hits_enemy_game_over)
	GameEvents.time_expired_game_over.disconnect(_on_time_expired_game_over)
	GameEvents.emit_increase_score(player.score_for_eating)
