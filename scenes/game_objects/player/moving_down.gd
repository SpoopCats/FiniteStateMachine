extends State


class_name MovingDown


@onready var player: CharacterBody2D = $"../.."
@onready var score_bonus: AudioStreamPlayer2D = $"../../ScoreBonus"
@export var pts_label_scene: PackedScene


var dir: Vector2 = Vector2.DOWN
var speed: int = 470
var player_velocity = dir * speed
var collision_info: KinematicCollision2D


func Enter():
	print("State = MovingDown")
	pass


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
			#placeholder code for something that happens when Ralph hits enemies
			GameOver.play()
			# change the boolean value in GameOverManager for how the game ended
			GameEvents.emit_player_hits_enemy_game_over()
			# if score is higher than high score, save the high score
			if ScoreManager.current_score > ScoreManager.high_score:
				ScoreManager.save_score()
			get_tree().change_scene_to_file('res://scenes/UI/game_over_menu/game_over_menu.tscn')


func Exit():
	GameEvents.emit_increase_score(player.score_for_eating)
	pass
