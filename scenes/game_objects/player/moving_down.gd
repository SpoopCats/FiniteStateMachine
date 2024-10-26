extends State
class_name MovingDown


@onready var player: CharacterBody2D = $"../.."
# provides a reference to enemy root node
@onready var ememies = get_tree().get_first_node_in_group("enemy") as CharacterBody2D

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
		# compares collider to first node in enemy group
		if collision_info.get_collider() == ememies:
			#placeholder code for something that happens when Ralph hits enemies
			print("enemy!")
			player.queue_free()
			ememies.queue_free()


func Exit():
	GameEvents.emit_increase_score()
	pass
