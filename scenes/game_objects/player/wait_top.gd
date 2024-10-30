extends State
class_name WaitTop


func Enter():
	# emit signal to instantiate food on btm pedestal
	GameEvents.emit_spawn_food_btm()
	print("State = WaitTop")
	pass


func Update(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingdown")

func Physics_Update(delta: float):
	pass


func Exit():
	pass
