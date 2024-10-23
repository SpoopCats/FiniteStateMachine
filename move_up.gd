extends State
class_name MoveUp

@onready var player: CharacterBody2D = $"../.."
var top_of_screen: Vector2 = Vector2(960, 40)

func Enter():
	print("State = MoveUp")

func Physics_Update(delta: float):
	player.velocity = Vector2.UP * player.move_speed
	if player.position == top_of_screen:
		Transitioned.emit(self, 'WaitTop')
		# wait top does not exist yet!!!
