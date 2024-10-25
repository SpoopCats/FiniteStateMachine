extends State
class_name MovingUp

@onready var player: CharacterBody2D = $"../.."
var dir: Vector2 = Vector2.UP
var speed: int = 1400
var player_velocity = dir * speed
var collision_info: KinematicCollision2D


func enter():
	print("State = MovingUp")
	pass


func Update(delta: float):
	pass


func Physics_Update(delta: float):
	collision_info = player.move_and_collide(player_velocity * delta)
	if collision_info:
		if collision_info.get_collider().get('name') == 'TopPedestal':
			print(collision_info.get_collider().get('name'))
			Transitioned.emit(self, "waittop")


func exit():
	pass
