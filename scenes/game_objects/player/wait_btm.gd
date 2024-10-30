extends State
class_name WaitBtm


func Enter():
	# emit signal to instantiate food on top pedestal
	GameEvents.emit_spawn_food_top()
	print("State = WaitBtm")



func Update(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingup")

func Physics_Update(delta: float):
	pass


func Exit():
	pass
