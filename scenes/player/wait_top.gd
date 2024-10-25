extends State
class_name WaitTop


func enter():
	print("State = WaitTop")
	pass


func Update(delta: float):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, "movingdown")

func Physics_Update(delta: float):
	pass


func exit():
	pass
