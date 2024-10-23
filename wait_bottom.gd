extends State
class_name WaitBottom

@onready var player: CharacterBody2D = $"../.."
var btm_of_screen: Vector2 = Vector2(960, 1020) # bottom of screen + 20 to get to center of square

func Enter():
	player.global_position = btm_of_screen
