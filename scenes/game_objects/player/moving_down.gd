extends State


class_name MovingDown


@onready var player: CharacterBody2D = $"../.."


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
		if node_collided_with.is_in_group('enemy'):
			#placeholder code for something that happens when Ralph hits enemies
			print("enemy!")
			player.queue_free()
			node_collided_with.queue_free()


func Exit():
	GameEvents.emit_increase_score(player.score_for_eating)
	pass
