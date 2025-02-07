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
		if collision_info.get_collider().get('name') == 'BtmPedestal':
			print(collision_info.get_collider().get('name'))
			Transitioned.emit(self, "waitbtm")


func Exit():
	pass
