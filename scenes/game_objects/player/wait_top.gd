extends State
class_name WaitTop

@onready var top_sfx: AudioStreamPlayer2D = $"../../TopSfx"


func Enter():
	# emit signal to instantiate food on btm pedestal
	top_sfx.play()
	GameEvents.emit_spawn_food_btm()


func Update(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingdown")

func Physics_Update(delta: float):
	pass


func Exit():
	pass
